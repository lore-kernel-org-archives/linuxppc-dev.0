Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0082.outbound.protection.outlook.com [104.47.33.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zPV24S0ZzDrC4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Aug 2018 18:01:30 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: 11 minute NTP hw clock update racy?
Date: Mon, 27 Aug 2018 08:01:15 +0000
Message-ID: <472091f06a11d4525dc655c78bfeb6e82b71ed2a.camel@infinera.com>
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

V2Ugc2VlIGNvcnJ1cHQgSFcgY2xvY2sgdGltZSBldmVyeSBub3cgYW5kIHRoZW4ocmVhbGx5IGhh
cmQgdG8gcmVwcm9kdWNlKQ0KT3VyIFJUQyBpcyBhIERTMTM4OCBvbiBhbiBJMkMgYnVzLg0KDQpM
b29raW5nIGF0IG50cF9ub3RpZnlfY21vc190aW1lcigpIGFuZCBpdCdzIGRlbGF5ZWQgd29yayBx
dWV1ZSBpbXBsLiBJIHdvbmRlcg0KaWYgdGhlcmUgY291bGQgYmUgYSByYWNlIGhlcmUgdy5yLnQg
cmVib290ID8NCg0KQ291bGQgdGhlIDExIG1pbnV0ZSB1cGRhdGUga2ljayBpbiBqdXN0IGFzIHRo
ZSBzeXN0ZW0gaXMgYWJvdXQgdG8gcmVzZXQNCnRoZSBDUFU/DQoNCkkgYW0gb24gNC4xNC41MSwg
cHBjMzIgYW5kIHVzaW5nIHRoZSBwcGNfbWQucmVzdGFydCgpIGhvb2sgd2hpY2ggd2lsbA0KcmVz
ZXQgdGhlIENQVSBpbW1lZGlhdGVseS4NCg0KUXVlc3Rpb24sIGlzIHNhZmUgdG8gY2FsbCBudHBf
bm90aWZ5X2Ntb3NfdGltZXIoKSB3aGVuIHRoZSB3b3JrIHF1ZXVlIGlzIGFscmVhZHkNCmFybWVk
KGxpa2UgZG9fYWRqdGltZXgoKSBkb2VzKSA/IA0KDQogSm9ja2UNCg==
