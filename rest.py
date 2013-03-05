# -*- coding: utf-8 -*-
import web
import os
import copy
import urllib
import time
from urllib import urlencode
from urllib import quote 
import json
urls = (
    '/', 'index',
    '/list_app','list_app',
    '/add_app','add_app',
    '/modify_app/(\d+)','modify_app',
    '/list_rest/(\d+)','list_rest',
    '/add_rest/(\d+)','add_rest',
    '/modify_rest/(\d+)','modify_rest',
    '/get_response','get_response',
)
render = web.template.render('templates/', base='layout') 
db = web.database(dbn='mysql',db='rest', host='127.0.0.1', port=3306, user='root', pw='')
web.template.Template.globals['json_loads'] = json.loads 
class index:
	def POST(self):
		web.redirect('/list_app')
		return 
	GET=POST	

class login:
	def GET(self):
		return render.login()	
class get_response:
	def GET(self):
		pdata = web.input()
		id = pdata.get("id")
		bind = {'id':id}
		result = db.select('rest', bind,where="id=$id")
		data = {} 
		if not result:
			data['code'] = '400'
			data['message'] = 'not find id'
			return json.dumps(data)
		rest = result[0]
		appid = str(rest['appid'])
		method = rest['method']
		api = rest['api']
		params = json.loads(rest['params'])
		app_bind = {'id':appid}
		apps = db.select('app', app_bind, where="id=$id")
		app = apps[0]	
		url = app['url']+api
		p_len = len(params)
		data = {}
		for p in range(p_len):	
			tag = "{"+params[p]['param']+"}"
			value = pdata.get("username") 
			if value == None:
				value =''
			if tag in url:
				url = url.replace(tag, value)
			else:
				data[params[p]['param']] = value

		dencode = urllib.urlencode(data)			
		if method == 'get':
				urlweb = urllib.urlopen(url+"?"+dencode)
		else:
				urlweb = urllib.urlopen(url,dencode)
		rdata = {}

		response = urlweb.info()
		rdata['url'] = urlweb.geturl()
		rdata['code'] = urlweb.getcode()
		if rdata['code'] == '200':
			rdata['body'] = urlweb.read()
		else:
			rdata['body'] = ''
		rdata['response'] = ''

		for u in response:
			rdata['response'] +=  u+":"+response[u]+"\r\n"

		return  json.dumps(rdata)
	POST=GET
class list_app:
	def GET(self):
		result = db.select('app')
		return render.list_app(result)

class list_rest:
	def GET(self, *params):
		appid = params[0]
		result = db.select('rest',where='appid='+appid)
		return render.list_rest(result)
class modify_app:
	def GET(self, *params):
		appid = params[0]
		data = web.input()
		apps = db.select('app', where='id='+appid)
		app = apps[0]
		info = data.get('info')
		if not app:
			web.redirect('/list_app?info='+quote("not find appid"))
			return 
		return render.modify_app(app,info)
	def POST(self,*params):
		appid = params[0]
		params = web.input()	
		title = params.get('title')
		summary = params.get('summary')
		url = params.get('url')
		if not title or  not summary  or not url:
			web.redirect('/add_app?info='+quote("标题，地址，描述不能为空"))
			return 
		app_id = db.update('app',where='id='+appid, title=title, summary=summary, url=url)	
		web.redirect('/list_app?info=success')	
		return 
	
class modify_rest:
	def GET(self, *params):
		id = params[0]
		data = web.input()
		info = data.get('info')
		result = db.select('rest',where="id="+id)
		if not result:
			web.redirect('/list_app?info='+quote("id empty."))
			return 
		return render.modify_rest(id,result[0],info)	
	def POST(self,*params):
		data = web.input(params=[],types=[],descript=[],require_index=[],rparams=[],rtypes=[],rdescript=[],code=[],codenote=[])
		udata = web.input()
		api = udata.get('api')
		method = udata.get('method')
		comment = udata.get('comment')
		author = udata.get('author')
		id = udata.get('id')
		summary = udata.get('summary')
		demo = udata.get('demo')
		if not id:
			web.redirect('/list_app?info='+quote("id empty."))
			return 
		bind = dict(id=id)
		result = db.select('rest',bind,where="id=$id")
		if not result:
			web.redirect('/list_app?info='+quote("not find  id."))
			return 
		if not api or not method or not comment or not author:
			web.redirect('/modify_rest/'+id+'?info='+quote("接口地址, 述述描述, 方式, 人接口人, 不能为空."))
			return 
		p_len = len(data.params)
		params_list = []
		for i in  range(p_len):
			if data.params[i]:
				params_dic = {}
				if  not data.types[i] :
					web.redirect('/add_rest/'+id+'?info='+data.params[i]+quote("的参数类型不能为空."))
					return
				required = udata.get('required['+str(data.require_index[i])+']')
				params_dic['param'] = data.params[i]
				params_dic['type'] = data.types[i]
				params_dic['descript'] = data.descript[i]
				params_dic['required'] = required 
				params_list.append(params_dic)
			
		params_data = json.dumps(params_list)
		
		r_len = len(data.rparams)
		rparams_list = []
		for i in  range(r_len):
			if data.rparams[i]:
				rparams_dic = {}
				if  not data.rtypes[i] :
					web.redirect('/add_rest/'+id+'?info='+data.rparams[i]+quote("的返回值类型不能为空."))
					return 
				rparams_dic['rparam'] = data.rparams[i]
				rparams_dic['rtype'] = data.rtypes[i]
				rparams_dic['rdescript'] = data.rdescript[i]
				rparams_list.append(rparams_dic)
			
		rparams_data = json.dumps(rparams_list)
		
		c_len = len(data.code)
		code_list = []
		for i in  range(c_len):
			if data.code[i]:
				code_dic = {}
				code_dic['code'] = data.code[i]
				code_dic['codenote'] = data.codenote[i]
				code_list.append(code_dic)
			
		code_data = json.dumps(code_list)
		ctime = int(time.time())
		db.update('rest', where='id='+id,  api=api, comment=comment, summary=summary,
				  demo=demo,author=author,method=method,
				 params=params_data, returns=rparams_data,codes=code_data)			
		web.redirect('/list_app?info=success')	
		return data
class add_rest:
	def GET(self, *params):
		appid = params[0]
		app = db.select('app', where='id='+appid)
		if not app:
			web.redirect('/list_app?info='+quote("not find appid"))
			return 
		data = web.input()
		info = data.get('info')
		return render.add_rest(appid,info)	
	def POST(self,*params):
		data = web.input(params=[],types=[],descript=[],require_index=[],rparams=[],rtypes=[],rdescript=[],code=[],codenote=[])
		udata = web.input()
		api = udata.get('api')
		method = udata.get('method')
		comment = udata.get('comment')
		author = udata.get('author')
		appid = udata.get('appid')
		summary = udata.get('summary')
		demo = udata.get('demo')
		if not appid:
			web.redirect('/list_app?info='+quote("appid empty."))
			return 
		if not api or not method or not comment or not author:
			web.redirect('/add_rest/'+appid+'?info='+quote("接口地址, 述述描述, 方式, 人接口人, 不能为空."))
			return 
		p_len = len(data.params)
		params_list = []
		for i in  range(p_len):
			if data.params[i]:
				params_dic = {}
				if  not data.types[i] :
					web.redirect('/add_rest/'+appid+'?info='+data.params[i]+quote("的参数类型不能为空."))
					return
				required = udata.get('required['+str(data.require_index[i])+']')
				params_dic['param'] = data.params[i]
				params_dic['type'] = data.types[i]
				params_dic['descript'] = data.descript[i]
				params_dic['required'] = required 
				params_list.append(params_dic)
			
		params_data = json.dumps(params_list)
		
		r_len = len(data.rparams)
		rparams_list = []
		for i in  range(r_len):
			if data.rparams[i]:
				rparams_dic = {}
				if  not data.rtypes[i] :
					web.redirect('/add_rest/'+appid+'?info='+data.rparams[i]+quote("的返回值类型不能为空."))
					return 
				rparams_dic['rparam'] = data.rparams[i]
				rparams_dic['rtype'] = data.rtypes[i]
				rparams_dic['rdescript'] = data.rdescript[i]
				rparams_list.append(rparams_dic)
			
		rparams_data = json.dumps(rparams_list)
		
		c_len = len(data.code)
		code_list = []
		for i in  range(c_len):
			if data.code[i]:
				code_dic = {}
				code_dic['code'] = data.code[i]
				code_dic['codenote'] = data.codenote[i]
				code_list.append(code_dic)
			
		code_data = json.dumps(code_list)
		app = db.select('app', where='id='+appid)
		if not app:
			web.redirect('/list_app?info='+quote("not find appid"))
			return 
		ctime = int(time.time())
		db.insert('rest',appid=appid, api=api, comment=comment, summary=summary,
				  demo=demo,author=author,method=method,
				 params=params_data, returns=rparams_data,codes=code_data,
				ctime=ctime)			
		web.redirect('/list_app?info=success')	
		return data
class add_app:
	def GET(self):
		params = web.input()	
		info = params.get('info')
		return render.add_app(info)	
	def POST(self):
		params = web.input()	
		title = params.get('title')
		summary = params.get('summary')
		url = params.get('url')
		if not title or  not summary  or not url:
			web.redirect('/add_app?info='+quote("标题，地址，描述不能为空"))
			return 
		ctime = int(time.time())
		app_id = db.insert('app', title=title, summary=summary, url=url,ctime=ctime)	
		web.redirect('/list_app?info=success')	
		return 

if __name__ == "__main__":
    app = web.application(urls, globals())
    app.run()
