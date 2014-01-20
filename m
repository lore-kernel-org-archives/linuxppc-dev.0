Return-Path: <Yuantian.Tang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C1372C0090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 13:26:30 +1100 (EST)
From: Yuantian Tang <Yuantian.Tang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH v9] clk: corenet: Adds the clock binding
Date: Mon, 20 Jan 2014 02:26:21 +0000
Message-ID: <8dc96a3b72aa4960a673e75fc6d24605@BL2PR03MB115.namprd03.prod.outlook.com>
References: <1389600995-28293-1-git-send-email-Yuantian.Tang@freescale.com>
 <1390007187.24905.293.camel@snotra.buserror.net>
In-Reply-To: <1390007187.24905.293.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IDIwMTTlubQx5pyIMTjml6Ug5pif5pyf5YWtIDk6MDYNCj4gVG86IFRhbmcgWXVh
bnRpYW4tQjI5OTgzDQo+IENjOiBXb29kIFNjb3R0LUIwNzQyMTsgZ2FsYWtAa2VybmVsLmNyYXNo
aW5nLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgTGkgWWFuZy1MZW8tDQo+IFI1ODQ3
Mg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5XSBjbGs6IGNvcmVuZXQ6IEFkZHMgdGhlIGNsb2Nr
IGJpbmRpbmcNCj4gDQo+IE9uIE1vbiwgMjAxNC0wMS0xMyBhdCAxNjoxNiArMDgwMCwgVGFuZyBZ
dWFudGlhbiB3cm90ZToNCj4gPiArRXhhbXBsZSBmb3IgY2xvY2sgYmxvY2sgYW5kIGNsb2NrIHBy
b3ZpZGVyOg0KPiA+ICsvIHsNCj4gPiArCWNsb2NrZ2VuOiBnbG9iYWwtdXRpbGl0aWVzQGUxMDAw
IHsNCj4gPiArCQljb21wYXRpYmxlID0gImZzbCxwNTAyMC1jbG9ja2dlbiIsICJmc2wscW9yaXEt
Y2xvY2tnZW4tMS4wIjsNCj4gPiArCQlyYW5nZXMgPSA8MHgwIDB4ZTEwMDAgMHgxMDAwPjsNCj4g
PiArCQljbG9jay1mcmVxdWVuY3kgPSAxMzMzMzM7DQo+IA0KPiBNaXNzaW5nIDw+IGFyb3VuZCAx
MzMzMzMsIGFuZCB0aGUgYWN0dWFsIHA1MDIwZHMgaW5wdXQgY2xvY2sgKGJhc2VkIG9uDQo+IG9i
c2VydmluZyB3aGF0IFUtQm9vdCBmaWxscyBpbikgaXMgMTMzMzMzMzMzLCBub3QgMTMzMzMzLg0K
PiANClNvcnJ5LCA6KA0KDQo+IEknbGwgZml4IHdoZW4gYXBwbHlpbmcuDQo+IA0KVGhhbmsgeW91
IHZlcnkgbXVjaC4NCg0KUmVnYXJkcywNCll1YW50aWFuDQoNCj4gLVNjb3R0DQo+IA0KDQo=
