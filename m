Return-Path: <B08248@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D879B6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 06:32:36 +1000 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: pci node question
Date: Mon, 23 Apr 2012 20:32:23 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503347AB5@039-SN1MPN1-002.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E1503346013@039-SN1MPN1-002.039d.mgd.msft.net>
 <D04C6167-5286-4675-A6D8-32BA63305424@kernel.crashing.org>
 <1334956286.3197.16.camel@pasglop>
 <9F6FE96B71CF29479FF1CDC8046E150334747D@039-SN1MPN1-002.039d.mgd.msft.net>
 <1335212491.21619.23.camel@pasglop>
In-Reply-To: <1335212491.21619.23.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gU2VudDogTW9uZGF5
LCBBcHJpbCAyMywgMjAxMiAzOjIyIFBNDQo+IFRvOiBZb2RlciBTdHVhcnQtQjA4MjQ4DQo+IENj
OiBLdW1hciBHYWxhOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBS
RTogcGNpIG5vZGUgcXVlc3Rpb24NCj4gDQo+IE9uIE1vbiwgMjAxMi0wNC0yMyBhdCAxNTo0OCAr
MDAwMCwgWW9kZXIgU3R1YXJ0LUIwODI0OCB3cm90ZToNCj4gPiBIbW1tLi4uIEkgdmFndWVseSB1
bmRlcnN0YW5kIHdoYXQgeW91IGFyZSBzYXlpbmcuICAgQnV0IHdoeSBpcyB0aGUNCj4gPiBsZW5n
dGggemVybywgdGhhdCBpcyB3aGF0IGRvZXNuJ3QgbWFrZSBzZW5zZSBvbiB0aGUgc3VyZmFjZT8N
Cj4gDQo+IEFoIGluZGVlZCwgb24gd291bGQgdGhpbmsgdGhhdCB3ZSBjb3VsZCByZXByZXNlbnQg
dGhlIHJlYWwgc2l6ZSBvZiB0aGUNCj4gY29uZmlnIHNwYWNlIHRoZXJlLi4uIGJ1dCBJJ3ZlIGFs
d2F5cyBzZWVuIHRoaXMgYXMgMCBpbiByZWFsIE9GDQo+IGltcGxlbWVudGF0aW9ucyBhcyB3ZWxs
LCBhdCBsZWFzdCB0aGUgRzUgZGV2aWNlLXRyZWUgSSdtIGxvb2tpbmcgYXQgbm93DQo+IGhhcyBp
dCB0aGF0IHdheS4NCj4gDQo+ID4gV2UgcmVhbGx5IHNob3VsZCBwdXQgYSBjb21tZW50IG9uIHRo
YXQgcmVnIHByb3BlcnR5LS0gY2FuIHlvdSBzdWdnZXN0DQo+ID4gYSBzaG9ydCBjb21tZW50IHRo
YXQgd291bGQgY2FwdHVyZSB3aGF0IHRoZSByZWcgd2l0aCBhbGwgemVyb3MNCj4gPiBpcyBmb3I/
ICAuLi5JJ2xsIHN1Ym1pdCBhIHBhdGNoLg0KPiANCj4gSHJtLi4gImNvbmZpZyBhZGRyZXNzIG9m
IHRoZSBkZXZpY2U6IDAsMCwwIiA/DQoNCkhvdyBhYm91dDoNCg0KICAvKiBjb25maWcgc3BhY2Ug
YWRkcmVzcyBvZiB0aGUgZGV2aWNlIDAsMCwwLiBPRiBjb252ZW50aW9uIGlzIHRoYXQNCiAgICAg
dGhlIHNpemUgb2YgY29uZmlnIHNwYWNlIGlzIDAuICovDQoNCi4uLmlzIHRoYXQgYWNjdXJhdGU/
DQoNClN0dWFydA0K
