Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E28121A275A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 21:07:23 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michal Sojka' <sojkam1@fel.cvut.cz>, Michael Ellerman
 <mpe@ellerman.id.au>, Christophe LEROY <christophe.leroy@c-s.fr>
CC: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: memcpy regression
Date: Mon, 7 Sep 2015 10:59:01 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB8E77D@AcuExch.aculab.com>
References: <871teeux4w.fsf@steelpick.2x.cz> <55E9A354.6070600@c-s.fr>
 <87si6utfpf.fsf@steelpick.2x.cz> <55E9DE87.4070805@c-s.fr>
 <55E9F5CE.6050904@fel.cvut.cz> <55EA3281.3000806@fel.cvut.cz>
 <55EBF6CD.5010001@c-s.fr> <87twr74bdg.fsf@steelpick.2x.cz>
 <87r3mb4603.fsf@steelpick.2x.cz> <1441588450.12945.1.camel@ellerman.id.au>
 <55ED37D1.3080503@c-s.fr> <1441615249.8979.1.camel@ellerman.id.au>
 <55ED5CCE.5000200@fel.cvut.cz>
In-Reply-To: <55ED5CCE.5000200@fel.cvut.cz>
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

RnJvbTogTWljaGFsIFNvamthDQo+ID4+IEkgdGhpbmsgR0NDIHVzZXMgbWVtY3B5KCkgaW4gd2Vs
bCBrbm93biBzaXR1YXRpb25zIGxpa2UgaW5pdGlhbGlzaW5nDQo+ID4+IHN0cnVjdHVyZXMgb3Ig
Y29weWluZyBzdHJ1Y3R1cmVzLg0KPiA+PiBTaG91bGRuJ3Qgd2UganVzdCBhdm9pZCB0aGlzIGtp
bmQgb2YgYWN0aW9ucyBpbiB0aGUgdmVyeSBmZXcgZWFybHkgaW5pdA0KPiA+PiBmdW5jdGlvbnMg
Pw0KPiA+IFdoaWNoIGFyZSB0aGUgInZlcnkgZmV3IiBlYXJseSBpbml0IGZ1bmN0aW9ucz8gQ2Fu
IHlvdSBtYWtlIGEgbGlzdCwgZm9yIDMyLWJpdA0KPiA+IGFuZCA2NC1iaXQ/IEFuZCBjYW4gd2Ug
a2VlcCBpdCB1cGRhdGVkIG92ZXIgdGltZSBhbmQgbm90IGludHJvZHVjZSByZWdyZXNzaW9ucz8N
Cj4gPg0KPiBJZiB0aGUgY29kZSB0aGF0IHJ1bnMgd2l0aG91dCBjYWNoZXMgaXMgY29uY2VudHJh
dGVkIGluIGZldyBmaWxlcywgd2UNCj4gbWF5IGVpdGhlciBtb2RpZnkgdGhlIGJ1aWxkc3lzdGVt
IHRvIGNoZWNrIHdoZXRoZXIgdGhlcmUgaXMgYSBjYWxsIHRvDQo+IG1lbWNweSBmcm9tIHRoZXNl
IGZpbGVzIChlLmcuIGJ5IHVzaW5nIG5tKSBvciB0aGVzZSBmaWxlcyBjYW4gYmUNCj4gInByZWxp
bmtlZCIgd2l0aCBzcGVjaWFsIHZlcnNpb24gb2YgbWVtY3B5IHRoYXQgZG9lc24ndCByZXF1aXJl
IGNhY2hlcy4NCj4gV291bGQgYW55IG9mIHRoZXNlIGJlIGFjY2VwdGFibGU/DQoNCldoYXQgYWJv
dXQgcnVuLXRpbWUgcGF0Y2hpbmcgbWVtY3B5KCkgYWZ0ZXIgdGhlIGNhY2hlcyBhcmUgaW5pdGlh
bGlzZWQ/DQoNCglEYXZpZA0KDQo=
