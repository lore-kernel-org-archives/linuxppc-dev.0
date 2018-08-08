Return-Path: <bharat.bhushan@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03on0628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe08::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lchh0x8RzDqgw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 13:44:50 +1000 (AEST)
From: Bharat Bhushan <bharat.bhushan@nxp.com>
To: Scott Wood <oss@buserror.net>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "keescook@chromium.org"
 <keescook@chromium.org>, "tyreld@linux.vnet.ibm.com"
 <tyreld@linux.vnet.ibm.com>, "joe@perches.com" <joe@perches.com>
Subject: RE: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
Date: Wed, 8 Aug 2018 03:44:44 +0000
Message-ID: <AM5PR0401MB254592DC0E917FD292B323BA9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
 <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
 <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
In-Reply-To: <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2NvdHQgV29vZCBbbWFp
bHRvOm9zc0BidXNlcnJvci5uZXRdDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDgsIDIwMTgg
Mjo0NCBBTQ0KPiBUbzogQmhhcmF0IEJodXNoYW4gPGJoYXJhdC5iaHVzaGFuQG54cC5jb20+Ow0K
PiBiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc7IHBhdWx1c0BzYW1iYS5vcmc7IG1wZUBlbGxlcm1h
bi5pZC5hdTsNCj4gZ2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsgbWFyay5ydXRsYW5kQGFybS5j
b207DQo+IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGdyZWdraEBsaW51eGZvdW5kYXRp
b24ub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3Rz
Lm96bGFicy5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiByb2Jo
QGtlcm5lbC5vcmc7IGtlZXNjb29rQGNocm9taXVtLm9yZzsgdHlyZWxkQGxpbnV4LnZuZXQuaWJt
LmNvbTsNCj4gam9lQHBlcmNoZXMuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIDUvNV0gcG93ZXJw
Yy9mc2w6IEFkZCBzdXBwb3J0ZWQtaXJxLXJhbmdlcyBmb3IgUDIwMjANCj4gDQo+IE9uIEZyaSwg
MjAxOC0wNy0yNyBhdCAxNToxOCArMDUzMCwgQmhhcmF0IEJodXNoYW4gd3JvdGU6DQo+ID4gTVBJ
QyBvbiBOWFAgKEZyZWVzY2FsZSkgUDIwMjAgc3VwcG9ydHMgZm9sbG93aW5nIGlycQ0KPiA+IHJh
bmdlczoNCj4gPiAgID4gMCAtIDExICAgICAgKEV4dGVybmFsIGludGVycnVwdCkNCj4gPiAgID4g
MTYgLSA3OSAgICAgKEludGVybmFsIGludGVycnVwdCkNCj4gPiAgID4gMTc2IC0gMTgzICAgKE1l
c3NhZ2luZyBpbnRlcnJ1cHQpDQo+ID4gICA+IDIyNCAtIDIzMSAgIChTaGFyZWQgbWVzc2FnZSBz
aWduYWxlZCBpbnRlcnJ1cHQpDQo+IA0KPiBXaHkgZG9uJ3QgeW91IGNvbnZlcnQgdG8gdGhlIDQt
Y2VsbCBpbnRlcnJ1cHQgc3BlY2lmaWVycyB0aGF0IG1ha2UgZGVhbGluZw0KPiB3aXRoIHRoZXNl
IHJhbmdlcyBsZXNzIGVycm9yLXByb25lPw0KDQpPayAsIHdpbGwgZG8gaWYgd2UgYWdyZWUgdG8g
aGF2ZSB0aGlzIHNlcmllcyBhcyBwZXIgY29tbWVudCBvbiBvdGhlciBwYXRjaC4NCg0KPiANCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L21wYzg1eHhfcmRiLmMN
Cj4gPiBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9tcGM4NXh4X3JkYi5jDQo+ID4gaW5k
ZXggMTAwNjk1MC4uNDlmZjM0OCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZv
cm1zLzg1eHgvbXBjODV4eF9yZGIuYw0KPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
ODV4eC9tcGM4NXh4X3JkYi5jDQo+ID4gQEAgLTU3LDYgKzU3LDExIEBAIHZvaWQgX19pbml0IG1w
Yzg1eHhfcmRiX3BpY19pbml0KHZvaWQpDQo+ID4gIAkJCU1QSUNfQklHX0VORElBTiB8DQo+ID4g
IAkJCU1QSUNfU0lOR0xFX0RFU1RfQ1BVLA0KPiA+ICAJCQkwLCAyNTYsICIgT3BlblBJQyAgIik7
DQo+ID4gKwl9IGVsc2UgaWYgKG9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSgiZnNsLFAyMDIwUkRC
LVBDIikpIHsNCj4gPiArCQltcGljID0gbXBpY19hbGxvYyhOVUxMLCAwLA0KPiA+ICsJCSAgTVBJ
Q19CSUdfRU5ESUFOIHwNCj4gPiArCQkgIE1QSUNfU0lOR0xFX0RFU1RfQ1BVLA0KPiA+ICsJCSAg
MCwgMCwgIiBPcGVuUElDICAiKTsNCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJbXBpYyA9IG1waWNf
YWxsb2MoTlVMTCwgMCwNCj4gPiAgCQkgIE1QSUNfQklHX0VORElBTiB8DQo+IA0KPiBJIGRvbid0
IHRoaW5rIHdlIHdhbnQgdG8gZ3JvdyBhIGxpc3Qgb2YgZXZlcnkgc2luZ2xlIHJldmlzaW9uIG9m
IGV2ZXJ5IGJvYXJkIGluDQo+IHRoZXNlIHBsYXRmb3JtIGZpbGVzLg0KDQpPbmUgb3RoZXIgY29u
ZnVzaW5nIG9ic2VydmF0aW9uIEkgaGF2ZSBpcyB0aGF0ICJpcnFfY291bnQiIGZyb20gcGxhdGZv
cm0gY29kZSBpcyBnaXZlbiBwcmVjZWRlbmNlIG92ZXIgImxhc3QtaW50ZXJydXB0LXNvdXJjZSIg
aW4gZGV2aWNlLXRyZWUuDQpTaG91bGQgbm90IGRldmljZS10cmVlIHNob3VsZCBoYXZlIHByZWNl
ZGVuY2Ugb3RoZXJ3aXNlIHRoZXJlIGlzIG5vIHBvaW50IHVzaW5nICIgbGFzdC1pbnRlcnJ1cHQt
c291cmNlIiBpZiBwbGF0Zm9ybSBjb2RlIHBhc3NlcyAiaXJxX2NvdW50IiBpbiBtcGljX2FsbG9j
KCkuDQoNClRoYW5rcw0KLUJoYXJhdA0KDQo+IA0KPiAtU2NvdHQNCg0K
