Return-Path: <geoffrey.levand@am.sony.com>
Received: from ns4.sony.co.jp (NS4.Sony.CO.JP [137.153.0.44])
	by ozlabs.org (Postfix) with ESMTP id 15F1D67CB1
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 01:01:37 +1100 (EST)
Received: from mail6.sony.co.jp (localhost [127.0.0.1])
	by mail6.sony.co.jp (R8/Sony) with ESMTP id kAEE1VKL020132
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 23:01:31 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail6.sony.co.jp (R8/Sony) with SMTP id kAEE1Vcs020105
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 23:01:31 +0900 (JST)
Message-ID: <4559CC1A.4020106@am.sony.com>
Date: Tue, 14 Nov 2006 06:00:58 -0800
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
aXRpb25hbGx5IHdoZW4gUFMzUEYgaXMgc2VsZWN0ZWQuIEFzIGEgc2hvcnQtdGVybQ0KPiBmaXgs
IEknZCBjaGFuZ2UgdGhpcyB0byBkbw0KPiANCj4gICAgICAgICBib29sICJQQ0kgc3VwcG9ydCIg
aWYgNDB4IHx8IENQTTIgfHwgUFBDXzgzeHggfHwgUFBDXzg1eHggfHwgUFBDXzg2eHggXA0KPiAt
ICAgICAgICAgICAgICAgfHwgUFBDX01QQzUyeHggfHwgKEVNQkVEREVEICYmIFBQQ19JU0VSSUVT
KSB8fCBNUEM3NDQ4SFBDMg0KPiArICAgICAgICAgICAgICAgfHwgUFBDX01QQzUyeHggfHwgKEVN
QkVEREVEICYmIFBQQ19JU0VSSUVTKSB8fCBNUEM3NDQ4SFBDMiBcDQo+ICsgICAgICAgICAgICAg
ICB8fCBQUzNQRg0KPiAgICAgICAgIGRlZmF1bHQgeSBpZiAhNDB4ICYmICFDUE0yICYmICE4eHgg
JiYgIUFQVVMgJiYgIVBQQ184M3h4IFwNCj4gICAgICAgICAgICAgICAgJiYgIVBQQ184NXh4ICYm
ICFQUENfODZ4eA0KPiANCj4gV2hpY2ggbWFrZXMgUENJIHN1cHBvcnQgb3B0aW9uYWwgd2hlbiBQ
UzNQRiBpcyBzZWxlY3RlZC4NCg0KDQpUaGlzIHdvcmtzIE9LLiAgWW91IGFyZSBub3cgZ2l2ZW4g
dGhlIG9wdGlvbiB0byBlbmFibGUgUENJIHdpdGggUFMzUEYuDQoNCg0KPiBIb3dldmVyLCB0aGlz
IHN0aWxsDQo+IG1lYW5zIHRoYXQgeW91IGNhbiBjaG9vc2UgYnJva2VuIGNvbmZpZ3VyYXRpb25z
IChlLmcuIFBTRVJJRVM9eSwgUFMzUEY9eSwNCj4gUENJPW4pLg0KPiANCj4gVGhlIHJlYWwgZml4
IHNob3VsZCBiZSB0byBnZXQgcmlkIG9mIHRoZSBsb25nIGNvbmRpdGlvbmFsIGZvciBDT05GSUdf
UENJLA0KPiBhbmQgaGF2ZSBQQ0kgc2VsZWN0ZWQgYnkgdGhlIHBsYXRmb3JtcyB0aGVtc2VsdmVz
Og0KPiANCj4gY29uZmlnIFBQQ19QU0VSSUVTDQo+IAlzZWxlY3QgUENJDQoNCg0KWWVzLCB0aGF0
IHNlZW1zIHRoZSB3YXkgdG8gZ28uDQoNCi1HZW9mZg0K
