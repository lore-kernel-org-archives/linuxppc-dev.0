Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D7F9B1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 19:00:58 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>
CC: 'Michal Sojka' <sojkam1@fel.cvut.cz>, Christophe LEROY
 <christophe.leroy@c-s.fr>, Scott Wood <scottwood@freescale.com>, "Paul
 Mackerras" <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: memcpy regression
Date: Tue, 8 Sep 2015 08:59:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB8FD26@AcuExch.aculab.com>
References: <871teeux4w.fsf@steelpick.2x.cz> <55E9A354.6070600@c-s.fr>
 <87si6utfpf.fsf@steelpick.2x.cz> <55E9DE87.4070805@c-s.fr>
 <55E9F5CE.6050904@fel.cvut.cz> <55EA3281.3000806@fel.cvut.cz>
 <55EBF6CD.5010001@c-s.fr> <87twr74bdg.fsf@steelpick.2x.cz>
 <87r3mb4603.fsf@steelpick.2x.cz> <1441588450.12945.1.camel@ellerman.id.au>
 <55ED37D1.3080503@c-s.fr> <1441615249.8979.1.camel@ellerman.id.au>
 <55ED5CCE.5000200@fel.cvut.cz>
 <063D6719AE5E284EB5DD2968C1650D6D1CB8E77D@AcuExch.aculab.com>
 <1441684462.14597.3.camel@ellerman.id.au>
In-Reply-To: <1441684462.14597.3.camel@ellerman.id.au>
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

PiA+IFdoYXQgYWJvdXQgcnVuLXRpbWUgcGF0Y2hpbmcgbWVtY3B5KCkgYWZ0ZXIgdGhlIGNhY2hl
cyBhcmUgaW5pdGlhbGlzZWQ/DQo+IA0KPiBZZWFoLCB0aGF0J3MgdGhlIHNvbHV0aW9uIHdlIHVz
ZSBvbiA2NC1iaXQuDQo+IA0KPiBJdCBhbHNvIG1lYW5zIHlvdSBjYW4gaGF2ZSBjcHUgc3BlY2lm
aWMgb3B0aW1pc2F0aW9ucywgd2hpY2ggY2FuIGJlIHBhdGNoZWQgaW4NCj4gb3Igb3V0IHVzaW5n
IHRoZSBjcHUgZmVhdHVyZSBwYXRjaGluZy4NCg0KSSd2ZSBub3RpY2VkIHg4NiBkb2luZyB0aGF0
Lg0KRm9yIG5ld2VyIEludGVsIHBhcnRzIGl0IHBhdGNoZXMgaW4gJ3JlcCBtb3ZzYicgYnV0IHVu
Zm9ydHVuYXRlbHkNCm1lbWNweV9pbyBpcyBhbHdheXMgI2RlZmluZWQgdG8gbWVtY3B5Lg0KDQpG
b3IgdW5jYWNoZWQgdGFyZ2V0cyB0aGUgaGFyZHdhcmUgY2FuJ3Qgb3B0aW1pc2UgcmVwIG1vdnNi
IC0gc28geW91DQplbmQgdXAgd2l0aCBieXRlIGFjY2Vzc2VzLg0KVGhlc2Ugd29yayBjYW4gYmUg
cmF0aGVyIHNsb3dlciB0aGFuIGV4cGVjdGVkLg0KDQpUaGlzIGFsc28gYWZmZWN0cyB1c2Vyc3Bh
Y2UgY29waWVzIHRvIG1tYXAoKWVkIFBDSWUgc3BhY2UuDQoNCglEYXZpZA0K
