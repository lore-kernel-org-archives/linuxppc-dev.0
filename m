Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id A14E4140080
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 19:08:29 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 21327-09 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 28 Apr 2014 10:08:17 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Li Zhong' <zhong@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>
Subject: RE: [RFC PATCH] Fix Oops in rtas_stop_self()
Date: Mon, 28 Apr 2014 09:06:36 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F700501@AcuExch.aculab.com>
References: <1398418381.2805.168.camel@ThinkPad-T5421.cn.ibm.com>
 <20140425221833.3cc04b0c@kryten> <1398644805.3046.7.camel@ThinkPad-T5421>
In-Reply-To: <1398644805.3046.7.camel@ThinkPad-T5421>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogTGkgWmhvbmcNCj4gT24gRnJpLCAyMDE0LTA0LTI1IGF0IDIyOjE4ICsxMDAwLCBBbnRv
biBCbGFuY2hhcmQgd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4gPiA+IFdoZW4gdHJ5aW5nIG9mZmxp
bmUgY3B1cywgSSBub3RpY2VkIGZvbGxvd2luZyBPb3BzIGluDQo+ID4gPiBydGFzX3N0b3Bfc2Vs
ZigpLCBhbmQgaXQgc2VlbXMgY2F1c2VkIGJ5IGNvbW1pdCA0MWRkMDNhOS4gVGhlIE9vcHMNCj4g
PiA+IGRpc2FwcGVhcnMgYWZ0ZXIgcmV2ZXJ0aW5nIHRoaXMgY29tbWl0Lg0KPiA+ID4NCj4gPiA+
IEFmdGVyIHJlYWRpbmcgdGhlIGNvZGUsIEkgZ3Vlc3MgaXQgbWlnaHQgYmUgY2F1c2VkIGJ5IG1v
dmluZyB0aGUNCj4gPiA+IHJ0YXNfYXJncyB0byBzdGFjay4gU3RpbGwgbmVlZCBzb21lIG1vcmUg
dGltZSB0byByZWFkIGVudGVyX3J0YXMgdG8NCj4gPiA+IHVuZGVyc3RhbmQgd2h5IGl0IGhhcHBl
bnMsIGJ1dCB0aGUgcHJvYmxlbSBzZWVtcyBjb3VsZCBiZSBzb2x2ZWQgYnkNCj4gPiA+IG1vdmlu
ZyB0aGUgcnRhc19hcmdzIGF3YXkgZnJvbSBzdGFjayBieSBhZGRpbmcgc3RhdGljIGJlZm9yZSBp
dC4NCj4gPg0KPiA+IE5pY2UgY2F0Y2guIFJUQVMgaXMgMzJiaXQgYW5kIGlmIHlvdXIgYm94IGhh
cyBtb3JlIHRoYW4gNEdCIFJBTSB0aGVuDQo+ID4geW91ciBzdGFjayBjb3VsZCBlYXNpbHkgYmUg
b3V0c2lkZSAzMmJpdCByYW5nZS4NCj4gDQo+IEFoLCB5ZXMsIHRoZSBzdGFjayBoZXJlIGlzIG9i
dmlvdXNseSBhdCBhIG11Y2ggaGlnaGVyIGFkZHJlc3MgdGhhbiA0R0IuDQoNCkFyZSB3ZSB0YWxr
aW5nIG9mIHBoeXNpY2FsIG9yIHZpcnR1YWwgYWRkcmVzc2VzIGhlcmU/DQoob3IgZXZlbiB1c2Vy
PykNCg0KSXMgdGhlcmUgYSByZS1lbnRyYW5jeSBwcm9ibGVtIHVzaW5nIGtlcm5lbCBzdGF0aWMg
ZGF0YT8NCg0KCURhdmlkDQoNCg==
