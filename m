Return-Path: <B45475@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1CFEC2C012D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 12:30:07 +1000 (EST)
Received: from mail20-am1 (localhost [127.0.0.1])	by mail20-am1-R.bigfish.com
 (Postfix) with ESMTP id 0C88520006D	for
 <linuxppc-dev@lists.ozlabs.org>; Sun,
 29 Sep 2013 02:30:02 +0000 (UTC)
Received: from AM1EHSMHS001.bigfish.com (unknown [10.3.201.253])	by
 mail20-am1.bigfish.com (Postfix) with ESMTP id B7B20600AC	for
 <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 02:29:59 +0000 (UTC)
From: Zhao Qiang-B45475 <B45475@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/p1010rdb:update dts to adapt to both old and
 new p1010rdb
Date: Sun, 29 Sep 2013 02:29:56 +0000
Message-ID: <36B508A30383C943B69CE30E685EB89CEB1A7A@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1379816919-13851-1-git-send-email-B45475@freescale.com>
 <1380317704.24959.491.camel@snotra.buserror.net>
In-Reply-To: <1380317704.24959.491.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Liu Shengzhou-B36685 <B36685@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T24gU2F0LCAyMDEzLTA5LTI4IGF0IDU6MzUgQU0sIFNjb3R0IHdyb3RlOg0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFNlbnQ6IFNh
dHVyZGF5LCBTZXB0ZW1iZXIgMjgsIDIwMTMgNTozNSBBTQ0KPiBUbzogWmhhbyBRaWFuZy1CNDU0
NzUNCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBMaXUgU2hlbmd6aG91LUIz
NjY4NQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwb3dlcnBjL3AxMDEwcmRiOnVwZGF0ZSBkdHMg
dG8gYWRhcHQgdG8gYm90aCBvbGQgYW5kDQo+IG5ldyBwMTAxMHJkYg0KPiANCj4gT24gU3VuLCAy
MDEzLTA5LTIyIGF0IDEwOjI4ICswODAwLCBaaGFvIFFpYW5nIHdyb3RlOg0KPiA+IFAxMDEwcmRi
LXBhIGFuZCBwMTAxMHJkYi1wYiBoYXZlIGRpZmZlcmVudCBwaHkgaW50ZXJydXB0cy4NCj4gPiBT
byB1cGRhdGUgZHRzIHRvIGFkYXB0IHRvIGJvdGggcDEwMTByZGItcGEgYW5kIHAxMDEwcmRiLXBi
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlbmd6aG91IExpdSA8U2hlbmd6aG91LkxpdUBm
cmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW8gUWlhbmcgPEI0NTQ3NUBmcmVl
c2NhbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3Bvd2VycGMvYm9vdC9kdHMvcDEwMTByZGIt
cGEuZHRzIHwgMzMgKysrKysrKysrKysrKysrKysrDQo+ID4gYXJjaC9wb3dlcnBjL2Jvb3QvZHRz
L3AxMDEwcmRiLXBiLmR0cyB8IDMzICsrKysrKysrKysrKysrKysrKw0KPiA+ICBhcmNoL3Bvd2Vy
cGMvYm9vdC9kdHMvcDEwMTByZGIuZHRzICAgIHwgNjYgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+IC0tLS0tLS0tDQo+ID4gIGFyY2gvcG93ZXJwYy9ib290L2R0cy9wMTAxMHJkYi5kdHNp
ICAgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4gPiAgNCBmaWxlcyBjaGFuZ2Vk
LCAxMTIgaW5zZXJ0aW9ucygrKSwgNzEgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEw
MDY0NCBhcmNoL3Bvd2VycGMvYm9vdC9kdHMvcDEwMTByZGItcGEuZHRzDQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL3Bvd2VycGMvYm9vdC9kdHMvcDEwMTByZGItcGIuZHRzDQo+ID4gIGRl
bGV0ZSBtb2RlIDEwMDY0NCBhcmNoL3Bvd2VycGMvYm9vdC9kdHMvcDEwMTByZGIuZHRzDQo+IA0K
PiBXaGF0IGFib3V0IHAxMDEwcmRiXzM2Yi5kdHM/DQo+IA0KPiAtU2NvdHQNCj4gDQoNClllcywg
d2UgcmVhbGx5IG5lZWQgdG8gdGFrZSAzNmIgaW50byBhY2NvdW50Lg0KTm93LCB0aGVyZSBpcyBh
bm90aGVyIHByb2JsZW0gdG8gYmUgZGlzY3Vzc2VkLg0KSWYgd2UganVzdCBhZGQgZmlsZXMgcDEw
MTByZGItcGIuZHRzIGFuZCBwMTAxMHJkYi1wYl8zNmIuZHRzLCB0aGVyZSB3aWxsIGJlIHNvbWUg
cmVkdW5kYW50IGNvZGVzLg0KSWYgd2Ugd2FudCB0byBhdm9pZCB0aGlzIHNpdHVhdGlvbiwgd2Ug
bmVlZCB0byBhZGQgdHdvIG1vcmUgZHRzaSBmaWxlcy4NCkxlc3MgY29kZXMgb3IgbGVzcyBmaWxl
cywgd2hpY2ggb25lIGRvIHlvdSBsaWtlIGJldHRlcj8NCg0KLVpoYW8gUWlhbmcNCg==
