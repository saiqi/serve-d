module served.http_wrap;

import served.http;
import served.types;
import served.lsputils;

import painlessjson : toJSON;

import std.json : JSON_TYPE;

__gshared bool letEditorDownload;

struct InteractiveDownload
{
	string url;
	string title;
	string output;
}

void downloadFile(string url, string title, string into)
{
	if (letEditorDownload)
	{
		if (rpc.sendRequest("coded/interactiveDownload", InteractiveDownload(url,
				title, into).toJSON).result.type != JSON_TYPE.TRUE)
			throw new Exception("The download has failed.");
	}
	else
	{
		downloadFileManual(url, title, into, (msg) {
			rpc.window.logInstall(msg);
		});
	}
}
