Return-Path: <liulijun@ict.ac.cn>
Received: from cstnet.cn (smtp15.cstnet.cn [159.226.251.15])
 by lists.ozlabs.org (Postfix) with ESMTP id 876BA1A1A5E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 16:33:23 +1000 (AEST)
Date: Mon, 27 Jul 2015 14:26:40 +0800
From: liulijun <liulijun@ict.ac.cn>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Reply-To: liulijun <liulijun@ict.ac.cn>
Subject: using srio in linux2.6.34.6  causes kernel panic
Mime-Version: 1.0
Message-ID: <2015072714264025850711@ict.ac.cn>
Content-Type: multipart/alternative;
 boundary="----=_001_NextPart523557877866_=----"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_001_NextPart523557877866_=----
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: base64

SSd2ZSBiZWVuIHN0cnVnZ2xpbmcgd2l0aCBhIGtlcm5lbCBwYW5pYyBkdXJpbmcgZW51bWVyYXRp
b24gb2YgYSBSYXBpZCBJTyBzeXN0ZW0uDQpJIGFtIHVzaW5nIHRoZSBBTTQxNDAgd2l0aCBGcmVl
c2NhbGUgUDQwODAgcHJvY2Vzc29yLiAgVGhlIExpbnV4IGtlcm5lbCd2ZXJzaW9uIGlzIDIuNi4z
NC42LiAgSSd2ZSBzZXQgcmlvaGRpZD0wIG9uIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lLkJ1dCB3
aGVuIHRoZSBPUyBib290cyB1cCx0aGUga2VybmVsIHBhbmljIGFzIGZvbGxvd2luZzoNCkRQLUxp
dGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIgKG9yZGVyOiAyLCAxNjM4NCBieXRlcykgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDEgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFJQQzogUmVnaXN0ZXJlZCB1ZHAgdHJhbnNwb3J0IG1vZHVsZS4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgUlBDOiBSZWdpc3RlcmVkIHRjcCB0cmFuc3BvcnQg
bW9kdWxlLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSUEM6IFJlZ2lzdGVyZWQgdGNw
IE5GU3Y0LjEgYmFja2NoYW5uZWwgdHJhbnNwb3J0IG1vZHVsZS4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNldHRpbmcg
RnJlZXNjYWxlIHN0YXRpYyBQQU1VL0lPTU1VIGNvbmZpZ3VyYXRpb24gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRnJlZXNjYWxlIFBvd2VyUVVJQ0MgTUlJIEJ1czogcHJvYmVkICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBTZXR0aW5nIHVwIFJhcGlkSU8gcGVlci10by1wZWVyIG5ldHdvcmsgL3Jh
cGlkaW9AZmZlMGMwMDAwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGZzbC1vZi1yaW8gZmZlMGMwMDAwLnJhcGlkaW86IE9m
LWRldmljZSBmdWxsIG5hbWUgL3JhcGlkaW9AZmZlMGMwMDAwICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnNsLW9mLXJpbyBmZmUwYzAwMDAu
cmFwaWRpbzogUmVnczogW21lbSAweGZmZTBjMDAwMC0weGZmZTBkZmZmZl0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmc2wtb2Ytcmlv
IGZmZTBjMDAwMC5yYXBpZGlvOiBMQVcgc3RhcnQgMHgwMDAwMDAwZGMwMDAwMDAwLCBzaXplIDB4
MDAwMDAwMDAwMjAwMDAwMC4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGZzbC1vZi1yaW8gZmZlMGMwMDAwLnJhcGlkaW86IGVycmlycTogMTYsIGJlbGxpcnE6IDU3LCB0
eGlycTogNjAsIHJ4aXJxIDYxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZnNsLW9mLXJpbyBmZmUwYzAwMDAucmFwaWRpbzogUmFwaWRJTyBQSFkgdHlw
ZTogc2VyaWFsICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBmc2wtb2YtcmlvIGZmZTBjMDAwMC5yYXBpZGlvOiBIYXJk
d2FyZSBwb3J0IHdpZHRoOiA0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZzbC1vZi1yaW8gZmZlMGMwMDAwLnJh
cGlkaW86IFRyYWluaW5nIGNvbm5lY3Rpb24gc3RhdHVzOiBGb3VyLWxhbmUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnNsLW9mLXJpbyBm
ZmUwYzAwMDAucmFwaWRpbzogUmFwaWRJTyBDb21tb24gVHJhbnNwb3J0IFN5c3RlbSBzaXplOiAy
NTYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBS
SU86IGVudW1lcmF0ZSBtYXN0ZXIgcG9ydCAwLCBSSU8wIG1wb3J0ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFVucmVjb3ZlcmFibGUgRlAgVW5hdmFpbGFibGUgRXhjZXB0aW9uIDgwMSBhdCBk
ZWFkYmVlYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgT29wczogVW5yZWNvdmVyYWJsZSBGUCBVbmF2YWlsYWJsZSBF
eGNlcHRpb24sIHNpZzogNiBbIzFdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTTVAgTlJfQ1BVUz04IEQwODAxLUFNNDE0
MCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxhc3Qgc3lzZnMgZmls
ZTogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTW9k
dWxlcyBsaW5rZWQgaW46ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBOSVA6IGRlYWRiZWVjIExSOiBjMDQ5NTkxNCBDVFI6IGRlYWRiZWVmICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFJFR1M6IGViMDczY2MwIFRSQVA6IDA4MDEgICBOb3QgdGFpbnRl
ZCAgKDIuNi4zNC42KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTVNSOiAwMDAyOTAwMiA8RUUsTUUsQ0U+ICBD
UjogMjQwNDIwMjQgIFhFUjogMDAwMDAwMDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUQVNLID0gZWIwNWRhMzBb
MV0gJ3N3YXBwZXInIFRIUkVBRDogZWIwNzIwMDAgQ1BVOiA2ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdQUjAw
OiBkZWFkYmVlZiBlYjA3M2Q3MCBlYjA1ZGEzMCBlYjFmYmMwMCAwMDAwMDBmZiAwMDAwMDAwMCAw
MDAwMDBmZiAwMDAwMDAwMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgR1BSMDg6IDAwMDAwMDA0IGViNTM5NjQwIGYxMTUwYzIwIGViNWMwMDAwIDI0MDQyMDIy
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBOSVAgW2RlYWRiZWVjXSAweGRlYWRiZWVjICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIExSIFtjMDQ5NTkxNF0gcmlvX2VudW1fcGVlcisw
eDFiOC8weDNlNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ2FsbCBUcmFjZTogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBbZWIwNzNk
NzBdIFtjMDQ5NThlNF0gcmlvX2VudW1fcGVlcisweDE4OC8weDNlNCAodW5yZWxpYWJsZSkgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFtlYjA3M2RkMF0gW2MwNDk1YzI4XSByaW9fZW51bV9tcG9ydCsweGU4LzB4MjQ0ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgW2ViMDczZTEwXSBbYzA0OTUwNGNdIHJpb19pbml0X21wb3J0cysweDkw
LzB4ZTQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBbZWIwNzNlMzBdIFtjMDQ5MjY0OF0gZnNsX29mX3Jp
b19ycG5fcHJvYmUrMHgzYy8weDUwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtlYjA3M2U0MF0gW2MwM2M2YTE0
XSBvZl9wbGF0Zm9ybV9kZXZpY2VfcHJvYmUrMHg1OC8weDk4ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2ViMDczZTYw
XSBbYzAyYjM5NWNdIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHhhNC8weDFiNCAgICAgICBbZWIwNzNl
ZDBdIFtjMDJiMmY5NF0gYnVzX3Byb2JlX2RldmljZSsweDJjLzB4NDQgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFtlYjA3M2VlMF0gW2MwMmIwYzM0XSBkZXZpY2VfYWRkKzB4NDBjLzB4NGMwICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgW2ViMDczZjMwXSBbYzAzYzY1ODBdIG9mX2RldmljZV9yZWdpc3Rlcisw
eDM0LzB4NDggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBbZWIwNzNmNDBdIFtjMDAwOTAxMF0gb2ZfcGxhdGZv
cm1fZGV2aWNlX2NyZWF0ZSsweDQ0LzB4NzQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtlYjA3M2Y1MF0gW2MwMDA5MjNj
XSBvZl9wbGF0Zm9ybV9idXNfcHJvYmUrMHgxMzAvMHgxNWMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW2ViMDczZjcw
XSBbYzA2MDdkOTBdIGRlY2xhcmVfb2ZfcGxhdGZvcm1fZGV2aWNlcysweDI0LzB4MTQwICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBbZWIwNzNmOTBdIFtjMDYwN2FiOF0gX19tYWNoaW5lX2luaXRjYWxsX2QwODAxX2RlY2xhcmVf
b2ZfcGxhdGZvcm1fZGV2aWNlcysweDJjLzB4M2NbZWIwNzNmYTBdIFtjMDAwMWRkMF0gZG9fb25l
X2luaXRjYWxsKzB4M2MvMHgxZDBbZWIwNzNmZDBdIFtjMDVmZTllY10ga2VybmVsX2luaXQrMHgx
OTAvMHgyMzBbZWIwNzNmZjBdIFtjMDAwZjgwNF0ga2VybmVsX3RocmVhZCsweDRjLzB4NjhJbnN0
cnVjdGlvbiBkdW1wOlhYWFhYWFhYIFhYWFhYWFhYIFhYWFhYWFhYIFhYWFhYWFhYIFhYWFhYWFhY
IFhYWFhYWFhYIFhYWFhYWFhYIFhYWFhYWFhYWFhYWFhYWFggWFhYWFhYWFggWFhYWFhYWFggWFhY
WFhYWFggWFhYWFhYWFggWFhYWFhYWFggWFhYWFhYWFggWFhYWFhYWFgtLS1bIGVuZCB0cmFjZSA1
NjFiYjIzNmM4MDA4NTFmIF0tLS1LZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogQXR0ZW1wdGVk
IHRvIGtpbGwgaW5pdCFDYWxsIFRyYWNlOltlYjA3M2JjMF0gW2MwMDA3NTQ4XSBzaG93X3N0YWNr
KzB4NDQvMHgxNjAgKHVucmVsaWFibGUpW2ViMDczYmYwXSBbYzA0OGU3NzRdIHBhbmljKzB4OTAv
MHgxMDRbZWIwNzNjNDBdIFtjMDA0NmIzOF0gZG9fZXhpdCsweDYxYy8weDY2OFtlYjA3M2M5MF0g
W2MwMDBjZjFjXSBkaWUrMHhkYy8weDFiOFtlYjA3M2NiMF0gW2MwMDEwMGUwXSByZXRfZnJvbV9l
eGNlcHQrMHgwLzB4MThbZWIwNzNkNzBdIFtjMDQ5NThlNF0gcmlvX2VudW1fcGVlcisweDE4OC8w
eDNlNFtlYjA3M2RkMF0gW2MwNDk1YzI4XSByaW9fZW51bV9tcG9ydCsweGU4LzB4MjQ0W2ViMDcz
ZTEwXSBbYzA0OTUwNGNdIHJpb19pbml0X21wb3J0cysweDkwLzB4ZTRbZWIwNzNlMzBdIFtjMDQ5
MjY0OF0gZnNsX29mX3Jpb19ycG5fcHJvYmUrMHgzYy8weDUwW2ViMDczZTQwXSBbYzAzYzZhMTRd
IG9mX3BsYXRmb3JtX2RldmljZV9wcm9iZSsweDU4LzB4OThbZWIwNzNlNjBdIFtjMDJiMzk1Y10g
ZHJpdmVyX3Byb2JlX2RldmljZSsweGE0LzB4MWI0W2ViMDczZTgwXSBbYzAyYjI1OThdIGJ1c19m
b3JfZWFjaF9kcnYrMHg2Yy8weGE4W2ViMDczZWIwXSBbYzAyYjM3ZTBdIGRldmljZV9hdHRhY2gr
MHhhNC8weGM4W2ViMDczZWQwXSBbYzAyYjJmOTRdIGJ1c19wcm9iZV9kZXZpY2UrMHgyYy8weDQ0
W2ViMDczZWUwXSBbYzAyYjBjMzRdIGRldmljZV9hZGQrMHg0MGMvMHg0YzBbZWIwNzNmMzBdIFtj
MDNjNjU4MF0gb2ZfZGV2aWNlX3JlZ2lzdGVyKzB4MzQvMHg0OFtlYjA3M2Y0MF0gW2MwMDA5MDEw
XSBvZl9wbGF0Zm9ybV9kZXZpY2VfY3JlYXRlKzB4NDQvMHg3NFtlYjA3M2Y1MF0gW2MwMDA5MjNj
XSBvZl9wbGF0Zm9ybV9idXNfcHJvYmUrMHgxMzAvMHgxNWNbZWIwNzNmNzBdIFtjMDYwN2Q5MF0g
ZGVjbGFyZV9vZl9wbGF0Zm9ybV9kZXZpY2VzKzB4MjQvMHgxNDBbZWIwNzNmOTBdIFtjMDYwN2Fi
OF0gX19tYWNoaW5lX2luaXRjYWxsX2QwODAxX2RlY2xhcmVfb2ZfcGxhdGZvcm1fZGV2aWNlcysw
eDJjLzB4M2NbZWIwNzNmYTBdIFtjMDAwMWRkMF0gZG9fb25lX2luaXRjYWxsKzB4M2MvMHgxZDBb
ZWIwNzNmZDBdIFtjMDVmZTllY10ga2VybmVsX2luaXQrMHgxOTAvMHgyMzBbZWIwNzNmZjBdIFtj
MDAwZjgwNF0ga2VybmVsX3RocmVhZCsweDRjLzB4NjhpcG1pIG1lc3NhZ2UgaGFuZGxlciB2ZXJz
aW9uIDM5LjJjb3VsZCBub3QgY3JlYXRlIElQTUkgdXNlciwgZXJyb3IgLTIyUmVib290aW5nIGlu
IDE4MCBzZWNvbmRzLi4gICAgICAgICAgICAgDQpJIGRvbm5vdCBrbm93IGhvdyB0byBkZWFsIHdp
dGggaXQuRG8geW91IGhhdmUgYW55IGlkZWFzPw0KVGhhbmtzIHZlcnkgbXVjaCEhDQoNCg0KDQoN
CmxpdWxpanVu

------=_001_NextPart523557877866_=----
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dus-ascii" http-equiv=3DContent-Type>
<STYLE>
BLOCKQUOTE {
	MARGIN-BOTTOM: 0px; MARGIN-LEFT: 2em; MARGIN-TOP: 0px
}
OL {
	MARGIN-BOTTOM: 0px; MARGIN-TOP: 0px
}
UL {
	MARGIN-BOTTOM: 0px; MARGIN-TOP: 0px
}
P {
	MARGIN-BOTTOM: 0px; MARGIN-TOP: 0px
}
BODY {
	FONT-SIZE: 10.5pt; FONT-FAMILY: Microsoft YaHei UI; COLOR: #000000; LINE-=
HEIGHT: 1.5
}
</STYLE>

<META name=3DGENERATOR content=3D"MSHTML 11.00.9600.17924"></HEAD>
<BODY style=3D"MARGIN: 10px">
<DIV><PRE style=3D"FONT-VARIANT: normal; WHITE-SPACE: pre-wrap; WORD-SPACI=
NG: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: normal; COLOR: rgb(0,0,0); FON=
T-STYLE: normal; WIDOWS: 1; LETTER-SPACING: normal; LINE-HEIGHT: normal; T=
EXT-INDENT: 0px; -webkit-text-stroke-width: 0px"><I style=3D"COLOR: #ff000=
0">I've been struggling with a kernel panic during enumeration of </I><I s=
tyle=3D"COLOR: #ff0000">a Rapid IO system.</I></PRE><PRE style=3D"FONT-VAR=
IANT: normal; WHITE-SPACE: pre-wrap; WORD-SPACING: 0px; TEXT-TRANSFORM: no=
ne; FONT-WEIGHT: normal; COLOR: rgb(0,0,0); FONT-STYLE: normal; WIDOWS: 1;=
 LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT: 0px; -webkit-te=
xt-stroke-width: 0px"><I style=3D"COLOR: #ff0000">I am using the AM4140 wi=
th Freescale P4080 </I><I style=3D"COLOR: #ff0000">processor. </I><EM styl=
e=3D"COLOR: #ff0000"> The Linux kernel'version is 2.6.34.6.  I've set rioh=
did=3D0 on the kernel command line.But </EM><EM style=3D"COLOR: #ff0000">w=
hen the OS boots up,the kernel panic as following:</EM></PRE><PRE style=3D=
"FONT-VARIANT: normal; WHITE-SPACE: pre-wrap; WORD-SPACING: 0px; TEXT-TRAN=
SFORM: none; FONT-WEIGHT: normal; COLOR: rgb(0,0,0); FONT-STYLE: normal; W=
IDOWS: 1; LETTER-SPACING: normal; LINE-HEIGHT: normal; TEXT-INDENT: 0px; -=
webkit-text-stroke-width: 0px"><DIV>DP-Lite&nbsp;hash&nbsp;table&nbsp;entr=
ies:&nbsp;512&nbsp;(order:&nbsp;2,&nbsp;16384&nbsp;bytes)&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>NET:&nbsp;Registered&nbsp;protocol&n=
bsp;family&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>RPC:&nbsp;Re=
gistered&nbsp;udp&nbsp;transport&nbsp;module.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>RPC:&nbs=
p;Registered&nbsp;tcp&nbsp;transport&nbsp;module.&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>RPC:=
&nbsp;Registered&nbsp;tcp&nbsp;NFSv4.1&nbsp;backchannel&nbsp;transport&nbs=
p;module.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>Setting&nbsp;Fre=
escale&nbsp;static&nbsp;PAMU/IOMMU&nbsp;configuration&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DI=
V>Freescale&nbsp;PowerQUICC&nbsp;MII&nbsp;Bus:&nbsp;probed&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
</DIV><DIV>Setting&nbsp;up&nbsp;RapidIO&nbsp;peer-to-peer&nbsp;network&nbs=
p;/rapidio@ffe0c0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>fsl-of-rio&=
nbsp;ffe0c0000.rapidio:&nbsp;Of-device&nbsp;full&nbsp;name&nbsp;/rapidio@f=
fe0c0000&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>fsl-of-ri=
o&nbsp;ffe0c0000.rapidio:&nbsp;Regs:&nbsp;[mem&nbsp;0xffe0c0000-0xffe0dfff=
f]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><D=
IV>fsl-of-rio&nbsp;ffe0c0000.rapidio:&nbsp;LAW&nbsp;start&nbsp;0x0000000dc=
0000000,&nbsp;size&nbsp;0x0000000002000000.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><=
DIV>fsl-of-rio&nbsp;ffe0c0000.rapidio:&nbsp;errirq:&nbsp;16,&nbsp;bellirq:=
&nbsp;57,&nbsp;txirq:&nbsp;60,&nbsp;rxirq&nbsp;61&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>fsl-=
of-rio&nbsp;ffe0c0000.rapidio:&nbsp;RapidIO&nbsp;PHY&nbsp;type:&nbsp;seria=
l&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>fsl-of=
-rio&nbsp;ffe0c0000.rapidio:&nbsp;Hardware&nbsp;port&nbsp;width:&nbsp;4&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DI=
V>fsl-of-rio&nbsp;ffe0c0000.rapidio:&nbsp;Training&nbsp;connection&nbsp;st=
atus:&nbsp;Four-lane&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</=
DIV><DIV>fsl-of-rio&nbsp;ffe0c0000.rapidio:&nbsp;RapidIO&nbsp;Common&nbsp;=
Transport&nbsp;System&nbsp;size:&nbsp;256&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV=
><DIV>RIO:&nbsp;enumerate&nbsp;master&nbsp;port&nbsp;0,&nbsp;RIO0&nbsp;mpo=
rt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV>=
<DIV>Unrecoverable&nbsp;FP&nbsp;Unavailable&nbsp;Exception&nbsp;801&nbsp;a=
t&nbsp;deadbeec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</D=
IV><DIV>Oops:&nbsp;Unrecoverable&nbsp;FP&nbsp;Unavailable&nbsp;Exception,&=
nbsp;sig:&nbsp;6&nbsp;[#1]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV=
>SMP&nbsp;NR_CPUS=3D8&nbsp;D0801-AM4140&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>last&nbsp;sysfs&nbsp;f=
ile:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><D=
IV>Modules&nbsp;linked&nbsp;in:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;</DIV><DIV>NIP:&nbsp;deadbeec&nbsp;LR:&nbsp;c0495914&nbsp;CTR:&nbsp=
;deadbeef&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;</DIV><DIV>REGS:&nbsp;eb073cc0&nbsp;TRAP:&nbsp;0801&nbsp;&nbsp;&nbsp;Not&=
nbsp;tainted&nbsp;&nbsp;(2.6.34.6)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>MSR:&nbsp;00029002&nbsp;&lt;E=
E,ME,CE&gt;&nbsp;&nbsp;CR:&nbsp;24042024&nbsp;&nbsp;XER:&nbsp;00000000&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>TASK&=
nbsp;=3D&nbsp;eb05da30[1]&nbsp;'swapper'&nbsp;THREAD:&nbsp;eb072000&nbsp;C=
PU:&nbsp;6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;</DIV><DIV>GPR00:&nbsp;deadbeef&nbsp;eb073d70&nbsp;eb05da30&nbsp;eb1fb=
c00&nbsp;000000ff&nbsp;00000000&nbsp;000000ff&nbsp;00000000&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>GPR08:&nbsp;000000=
04&nbsp;eb539640&nbsp;f1150c20&nbsp;eb5c0000&nbsp;24042022&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>NIP&n=
bsp;[deadbeec]&nbsp;0xdeadbeec&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>LR&nbsp;[c0495914]&nbsp;r=
io_enum_peer+0x1b8/0x3e4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>Call&nbsp;Trace:&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><=
DIV>[eb073d70]&nbsp;[c04958e4]&nbsp;rio_enum_peer+0x188/0x3e4&nbsp;(unreli=
able)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>[eb073dd0]&nbsp;[c0495c28]&nbsp;rio_en=
um_mport+0xe8/0x244&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>[eb073e10]&nbsp;[c04=
9504c]&nbsp;rio_init_mports+0x90/0xe4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>[e=
b073e30]&nbsp;[c0492648]&nbsp;fsl_of_rio_rpn_probe+0x3c/0x50&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>[eb073e40=
]&nbsp;[c03c6a14]&nbsp;of_platform_device_probe+0x58/0x98&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>[eb073e60]&nbsp;[c02b395c]&nbsp;driv=
er_probe_device+0xa4/0x1b4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[eb073=
ed0]&nbsp;[c02b2f94]&nbsp;bus_probe_device+0x2c/0x44&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DI=
V><DIV>[eb073ee0]&nbsp;[c02b0c34]&nbsp;device_add+0x40c/0x4c0&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>[eb073f30]&nbsp;[c03c6580]&nbsp;of=
_device_register+0x34/0x48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>[eb073f40]&nbsp;[c0009010]&nbsp=
;of_platform_device_create+0x44/0x74&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
</DIV><DIV>[eb073f50]&nbsp;[c000923c]&nbsp;of_platform_bus_probe+0x130/0x1=
5c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV><DIV>[eb073f70]&=
nbsp;[c0607d90]&nbsp;declare_of_platform_devices+0x24/0x140&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;</DIV><DIV>[eb073f90]&nbsp;[c0607ab8]&nbsp;__machine_initcall_d0801_d=
eclare_of_platform_devices+0x2c/0x3c</DIV><DIV>[eb073fa0]&nbsp;[c0001dd0]&=
nbsp;do_one_initcall+0x3c/0x1d0</DIV><DIV>[eb073fd0]&nbsp;[c05fe9ec]&nbsp;=
kernel_init+0x190/0x230</DIV><DIV>[eb073ff0]&nbsp;[c000f804]&nbsp;kernel_t=
hread+0x4c/0x68</DIV><DIV>Instruction&nbsp;dump:</DIV><DIV>XXXXXXXX&nbsp;X=
XXXXXXX&nbsp;XXXXXXXX&nbsp;XXXXXXXX&nbsp;XXXXXXXX&nbsp;XXXXXXXX&nbsp;XXXXX=
XXX&nbsp;XXXXXXXX</DIV><DIV>XXXXXXXX&nbsp;XXXXXXXX&nbsp;XXXXXXXX&nbsp;XXXX=
XXXX&nbsp;XXXXXXXX&nbsp;XXXXXXXX&nbsp;XXXXXXXX&nbsp;XXXXXXXX</DIV><DIV>---=
[&nbsp;end&nbsp;trace&nbsp;561bb236c800851f&nbsp;]---</DIV><DIV>Kernel&nbs=
p;panic&nbsp;-&nbsp;not&nbsp;syncing:&nbsp;Attempted&nbsp;to&nbsp;kill&nbs=
p;init!</DIV><DIV>Call&nbsp;Trace:</DIV><DIV>[eb073bc0]&nbsp;[c0007548]&nb=
sp;show_stack+0x44/0x160&nbsp;(unreliable)</DIV><DIV>[eb073bf0]&nbsp;[c048=
e774]&nbsp;panic+0x90/0x104</DIV><DIV>[eb073c40]&nbsp;[c0046b38]&nbsp;do_e=
xit+0x61c/0x668</DIV><DIV>[eb073c90]&nbsp;[c000cf1c]&nbsp;die+0xdc/0x1b8</=
DIV><DIV>[eb073cb0]&nbsp;[c00100e0]&nbsp;ret_from_except+0x0/0x18</DIV><DI=
V>[eb073d70]&nbsp;[c04958e4]&nbsp;rio_enum_peer+0x188/0x3e4</DIV><DIV>[eb0=
73dd0]&nbsp;[c0495c28]&nbsp;rio_enum_mport+0xe8/0x244</DIV><DIV>[eb073e10]=
&nbsp;[c049504c]&nbsp;rio_init_mports+0x90/0xe4</DIV><DIV>[eb073e30]&nbsp;=
[c0492648]&nbsp;fsl_of_rio_rpn_probe+0x3c/0x50</DIV><DIV>[eb073e40]&nbsp;[=
c03c6a14]&nbsp;of_platform_device_probe+0x58/0x98</DIV><DIV>[eb073e60]&nbs=
p;[c02b395c]&nbsp;driver_probe_device+0xa4/0x1b4</DIV><DIV>[eb073e80]&nbsp=
;[c02b2598]&nbsp;bus_for_each_drv+0x6c/0xa8</DIV><DIV>[eb073eb0]&nbsp;[c02=
b37e0]&nbsp;device_attach+0xa4/0xc8</DIV><DIV>[eb073ed0]&nbsp;[c02b2f94]&n=
bsp;bus_probe_device+0x2c/0x44</DIV><DIV>[eb073ee0]&nbsp;[c02b0c34]&nbsp;d=
evice_add+0x40c/0x4c0</DIV><DIV>[eb073f30]&nbsp;[c03c6580]&nbsp;of_device_=
register+0x34/0x48</DIV><DIV>[eb073f40]&nbsp;[c0009010]&nbsp;of_platform_d=
evice_create+0x44/0x74</DIV><DIV>[eb073f50]&nbsp;[c000923c]&nbsp;of_platfo=
rm_bus_probe+0x130/0x15c</DIV><DIV>[eb073f70]&nbsp;[c0607d90]&nbsp;declare=
_of_platform_devices+0x24/0x140</DIV><DIV>[eb073f90]&nbsp;[c0607ab8]&nbsp;=
__machine_initcall_d0801_declare_of_platform_devices+0x2c/0x3c</DIV><DIV>[=
eb073fa0]&nbsp;[c0001dd0]&nbsp;do_one_initcall+0x3c/0x1d0</DIV><DIV>[eb073=
fd0]&nbsp;[c05fe9ec]&nbsp;kernel_init+0x190/0x230</DIV><DIV>[eb073ff0]&nbs=
p;[c000f804]&nbsp;kernel_thread+0x4c/0x68</DIV><DIV>ipmi&nbsp;message&nbsp=
;handler&nbsp;version&nbsp;39.2</DIV><DIV>could&nbsp;not&nbsp;create&nbsp;=
IPMI&nbsp;user,&nbsp;error&nbsp;-22</DIV><DIV>Rebooting&nbsp;in&nbsp;180&n=
bsp;seconds..</DIV><DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;</DIV></PRE><PRE style=3D"FONT-VARIANT: normal=
; WHITE-SPACE: pre-wrap; WORD-SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEI=
GHT: normal; COLOR: rgb(0,0,0); FONT-STYLE: normal; WIDOWS: 1; LETTER-SPAC=
ING: normal; LINE-HEIGHT: normal; TEXT-INDENT: 0px; -webkit-text-stroke-wi=
dth: 0px"><EM>I donnot know how to deal with it.Do you have any ideas?</EM=
></PRE><PRE style=3D"FONT-VARIANT: normal; WHITE-SPACE: pre-wrap; WORD-SPA=
CING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: normal; COLOR: rgb(0,0,0); F=
ONT-STYLE: normal; WIDOWS: 1; LETTER-SPACING: normal; LINE-HEIGHT: normal;=
 TEXT-INDENT: 0px; -webkit-text-stroke-width: 0px"><EM>Thanks very much!!<=
/EM></PRE><PRE style=3D"FONT-VARIANT: normal; WHITE-SPACE: pre-wrap; WORD-=
SPACING: 0px; TEXT-TRANSFORM: none; FONT-WEIGHT: normal; COLOR: rgb(0,0,0)=
; FONT-STYLE: normal; WIDOWS: 1; LETTER-SPACING: normal; LINE-HEIGHT: norm=
al; TEXT-INDENT: 0px; -webkit-text-stroke-width: 0px"><EM></EM>&nbsp;</PRE=
></DIV>
<HR style=3D"HEIGHT: 1px; WIDTH: 210px" align=3Dleft color=3D#b5c4df SIZE=
=3D1>

<DIV><SPAN>liulijun</SPAN></DIV></BODY></HTML>

------=_001_NextPart523557877866_=------
