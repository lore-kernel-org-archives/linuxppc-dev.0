Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw3.sony.co.jp (MGW3.Sony.CO.JP [137.153.0.15])
	by ozlabs.org (Postfix) with ESMTP id D17E967D37
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:29:32 +1100 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id kAD3TQsa015355
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 12:29:26 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail5.sony.co.jp (R8/Sony) with SMTP id kAD3TQdI015347
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 12:29:26 +0900 (JST)
Message-ID: <4557E690.6070906@am.sony.com>
Date: Sun, 12 Nov 2006 19:29:20 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
References: <4554DACB.8060809@am.sony.com> <200611111250.59279.arnd@arndb.de>
In-Reply-To: <200611111250.59279.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

QXJuZCBCZXJnbWFubiB3cm90ZToNCj4gT24gRnJpZGF5IDEwIE5vdmVtYmVyIDIwMDYgMjE6MDIs
IEdlb2ZmIExldmFuZCB3cm90ZToNCj4+IEBAIC04NzYsNyArODg1LDcgQEANCj4+IO+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/vWJvb2wgIlBDSSBzdXBwb3J0IiBpZiA0MHggfHwgQ1BNMiB8fCBQUENf
ODN4eCB8fCBQUENfODV4eCB8fCBQUENfODZ4eCBcDQo+PiDvv73vv73vv73vv73vv73vv73vv73v
v73vv73vv73vv73vv73vv73vv73vv73vv718fCBQUENfTVBDNTJ4eCB8fCAoRU1CRURERUQgJiYg
UFBDX0lTRVJJRVMpIHx8IE1QQzc0NDhIUEMyDQo+PiDvv73vv73vv73vv73vv73vv73vv73vv71k
ZWZhdWx0IHkgaWYgITQweCAmJiAhQ1BNMiAmJiAhOHh4ICYmICFBUFVTICYmICFQUENfODN4eCBc
DQo+PiAt77+977+977+977+977+977+977+977+977+977+977+977+977+977+977+9JiYgIVBQ
Q184NXh4ICYmICFQUENfODZ4eA0KPj4gK++/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/vSYmICFQUENfODV4eCAmJiAhUFBDXzg2eHggJiYgIVBTM1BGDQo+PiDvv73v
v73vv73vv73vv73vv73vv73vv71kZWZhdWx0IFBDSV9QRVJNRURJQSBpZiAhNHh4ICYmICFDUE0y
ICYmICE4eHggJiYgQVBVUw0KPj4g77+977+977+977+977+977+977+977+9ZGVmYXVsdCBQQ0lf
UVNQQU4gaWYgITR4eCAmJiAhQ1BNMiAmJiA4eHgNCj4+IO+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
vWhlbHANCj4gDQo+IFRoaXMgY2hhbmdlIGNhdXNlcyB0cm91YmxlIHdoZW4gdHJ5aW5nIHRvIGJ1
aWxkIGEgbXVsdGlwbGF0Zm9ybSBrZXJuZWwNCj4gdGhhdCBpbmNsdWRlcyBQUzNQRiBhbmQgb3Ro
ZXJzIGF0IHRoZSBzYW1lIHRpbWUsIGJlY2F1c2UgUENJIGdldHMNCj4gZGlzYWJsZWQgdW5jb25k
aXRpb25hbGx5IHdoZW4gUFMzUEYgaXMgc2VsZWN0ZWQuDQoNCg0KT0ssIEkgZGlkbid0IGRvIGFu
eSBtdWx0aS1wbGF0Zm9ybSB0ZXN0aW5nIHlldCwgYnV0IEknbGwgc3RhcnQuDQoNCg0KQXMgYSBz
aG9ydC10ZXJtDQo+IGZpeCwgSSdkIGNoYW5nZSB0aGlzIHRvIGRvDQo+IA0KPiAgICAgICAgIGJv
b2wgIlBDSSBzdXBwb3J0IiBpZiA0MHggfHwgQ1BNMiB8fCBQUENfODN4eCB8fCBQUENfODV4eCB8
fCBQUENfODZ4eCBcDQo+IC0gICAgICAgICAgICAgICB8fCBQUENfTVBDNTJ4eCB8fCAoRU1CRURE
RUQgJiYgUFBDX0lTRVJJRVMpIHx8IE1QQzc0NDhIUEMyDQo+ICsgICAgICAgICAgICAgICB8fCBQ
UENfTVBDNTJ4eCB8fCAoRU1CRURERUQgJiYgUFBDX0lTRVJJRVMpIHx8IE1QQzc0NDhIUEMyIFwN
Cj4gKyAgICAgICAgICAgICAgIHx8IFBTM1BGDQo+ICAgICAgICAgZGVmYXVsdCB5IGlmICE0MHgg
JiYgIUNQTTIgJiYgITh4eCAmJiAhQVBVUyAmJiAhUFBDXzgzeHggXA0KPiAgICAgICAgICAgICAg
ICAmJiAhUFBDXzg1eHggJiYgIVBQQ184Nnh4DQo+IA0KPiBXaGljaCBtYWtlcyBQQ0kgc3VwcG9y
dCBvcHRpb25hbCB3aGVuIFBTM1BGIGlzIHNlbGVjdGVkLiBIb3dldmVyLCB0aGlzIHN0aWxsDQo+
IG1lYW5zIHRoYXQgeW91IGNhbiBjaG9vc2UgYnJva2VuIGNvbmZpZ3VyYXRpb25zIChlLmcuIFBT
RVJJRVM9eSwgUFMzUEY9eSwNCj4gUENJPW4pLg0KDQoNCk9LLCBJJ2xsIHRyeSBpdC4NCg0KDQo+
IFRoZSByZWFsIGZpeCBzaG91bGQgYmUgdG8gZ2V0IHJpZCBvZiB0aGUgbG9uZyBjb25kaXRpb25h
bCBmb3IgQ09ORklHX1BDSSwNCj4gYW5kIGhhdmUgUENJIHNlbGVjdGVkIGJ5IHRoZSBwbGF0Zm9y
bXMgdGhlbXNlbHZlczoNCj4gDQo+IGNvbmZpZyBQUENfUFNFUklFUw0KPiAJc2VsZWN0IFBDSQ0K
DQoNClllcywgd2UgY2FuIHdvcmsgdG93YXJkcyB0aGF0Lg0KDQotR2VvZmYNCg==
