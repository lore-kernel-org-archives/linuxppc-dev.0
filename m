Return-Path: <Yuantian.Tang@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C543C1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 20:16:30 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0145.outbound.protection.outlook.com [157.56.111.145])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C9EE2140187
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 20:16:29 +1100 (AEDT)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: RE: [PATCH 2/2] cpufreq: qoriq: rename the driver
Date: Fri, 21 Nov 2014 09:16:23 +0000
Message-ID: <dedc11e3150d44ee89bb1e96b5447687@DM2PR03MB574.namprd03.prod.outlook.com>
References: <1416554882-16566-1-git-send-email-Yuantian.Tang@freescale.com>
 <1416554882-16566-2-git-send-email-Yuantian.Tang@freescale.com>
 <CAKohpo=xLOxXrCJNO0LmrVxMDNsFy2Kxg6bNzHm=vQCJnBvSaw@mail.gmail.com>
In-Reply-To: <CAKohpo=xLOxXrCJNO0LmrVxMDNsFy2Kxg6bNzHm=vQCJnBvSaw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGVsbG8gVmlyZXNoLA0KDQpXaGVuIEkgdXNlIC1DIC1NIG9wdGlvbnMsIGNoZWNrcGF0Y2ggcmVw
b3J0cyBlcnJvcjoNCg0KW3Rhbmd5dEB0aXRhbiBsaW51eC1wbV0kIC4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIDAwMDItY3B1ZnJlcS1xb3JpcS1yZW5hbWUtdGhlLWRyaXZlci5wYXRjaCANCldBUk5J
Tkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVl
ZCB1cGRhdGluZz8NCiMxNTogDQogZHJpdmVycy9jcHVmcmVxL3twcGMtY29yZW5ldC1jcHVmcmVx
LmMgPT4gcW9yaXEtY3B1ZnJlcS5jfSB8IDANCg0KRVJST1I6IERvZXMgbm90IGFwcGVhciB0byBi
ZSBhIHVuaWZpZWQtZGlmZiBmb3JtYXQgcGF0Y2gNCg0KdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5p
bmdzLCAwIGxpbmVzIGNoZWNrZWQNCg0KMDAwMi1jcHVmcmVxLXFvcmlxLXJlbmFtZS10aGUtZHJp
dmVyLnBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4NCg0KSSBqdXN0IHJl
bmFtZSBpdCBhbmQgZG8gbm90IGNoYW5nZSBhbnl0aW5nLiBJc24ndCB0aGF0IGFsbG93ZWQ/DQoN
ClRoYW5rcywNCll1YW50aWFuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogVmlyZXNoIEt1bWFyIFttYWlsdG86dmlyZXNoLmt1bWFyQGxpbmFyby5vcmddDQo+IFNlbnQ6
IEZyaWRheSwgTm92ZW1iZXIgMjEsIDIwMTQgMzo1NiBQTQ0KPiBUbzogVGFuZyBZdWFudGlhbi1C
Mjk5ODMNCj4gQ2M6IFJhZmFlbCBKLiBXeXNvY2tpOyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0
OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4cHBjLWRldkBvemxhYnMub3JnOyBK
aW4gWmhlbmd4aW9uZy1SNjQxODgNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGNwdWZyZXE6
IHFvcmlxOiByZW5hbWUgdGhlIGRyaXZlcg0KPiANCj4gT24gMjEgTm92ZW1iZXIgMjAxNCAxMjo1
OCwgVGFuZyBZdWFudGlhbiA8WXVhbnRpYW4uVGFuZ0BmcmVlc2NhbGUuY29tPg0KPiB3cm90ZToN
Cj4gPiBUaGlzIGRyaXZlciB3b3JrcyBvbiBhbGwgUW9ySVEgcGxhdGZvcm1zIHdoaWNoIGluY2x1
ZGUgQVJNLWJhc2VkIGNvcmVzDQo+ID4gYW5kIFBQQy1iYXNlZCBjb3Jlcy4NCj4gPiBSZW5hbWUg
aXQgaW4gb3JkZXIgdG8gcmVwcmVzZW50IGJldHRlci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFRhbmcgWXVhbnRpYW4gPFl1YW50aWFuLlRhbmdAZnJlZXNjYWxlLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9jcHVmcmVxL3BwYy1jb3JlbmV0LWNwdWZyZXEuYyB8IDM3MSAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvY3B1ZnJlcS9xb3JpcS1jcHVm
cmVxLmMgICAgICAgfCAzNzENCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDM3MSBpbnNlcnRpb25zKCspLCAzNzEgZGVsZXRpb25zKC0p
ICBkZWxldGUgbW9kZQ0KPiA+IDEwMDY0NCBkcml2ZXJzL2NwdWZyZXEvcHBjLWNvcmVuZXQtY3B1
ZnJlcS5jDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NwdWZyZXEvcW9yaXEtY3B1
ZnJlcS5jDQo+IA0KPiBUaGlzIGlzIG5vdCByZXZpZXdhYmxlIGF0IGFsbC4uIEhvdyBkbyBJIHZl
cmlmeSB0aGF0IHlvdSBoYXZlbid0IGNoYW5nZWQgc29tZXRoaW5nDQo+IGluIHRoZSBmaWxlcyBh
cyB3ZWxsID8NCj4gDQo+IFRvIG1ha2UgbGlmZSBlYXN5IGFsd2F5cyBjcmVhdGUgcGF0Y2hlcyB3
aXRoOg0KPiANCj4gZ2l0IGZvcm1hdC1wYXRjaCAtQyAtTQ0KPiANCj4gQWJvdmUgb3B0aW9ucyBo
YW5kbGUgcmVuYW1lcyBwcmV0dHkgd2VsbC4NCg==
