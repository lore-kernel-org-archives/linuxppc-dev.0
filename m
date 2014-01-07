Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0243.outbound.protection.outlook.com [207.46.163.243])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F01462C010E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 20:55:15 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] powerpc/mpic: supply a .disable callback
Date: Tue, 7 Jan 2014 09:55:06 +0000
Message-ID: <69769d8b345a40fc983e15683679095f@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389073086-6763-1-git-send-email-dongsheng.wang@freescale.com>
 <1389076738.11795.122.camel@snotra.buserror.net>
In-Reply-To: <1389076738.11795.122.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAwNywgMjAxNCAyOjM5IFBNDQo+IFRvOiBXYW5n
IERvbmdzaGVuZy1CNDA1MzQNCj4gQ2M6IGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZzsgbGludXhw
cGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcG93ZXJwYy9t
cGljOiBzdXBwbHkgYSAuZGlzYWJsZSBjYWxsYmFjaw0KPiANCj4gT24gVHVlLCAyMDE0LTAxLTA3
IGF0IDEzOjM4ICswODAwLCBEb25nc2hlbmcgV2FuZyB3cm90ZToNCj4gPiBGcm9tOiBXYW5nIERv
bmdzaGVuZyA8ZG9uZ3NoZW5nLndhbmdAZnJlZXNjYWxlLmNvbT4NCj4gDQo+IFdoeSBkaWQgeW91
IGNoYW5nZSB0aGUgYXV0aG9yIGZpZWxkPw0KPiANCjooLiBJIGZvcmdvdCB0aGF0LCBJIGFkZGVk
IHRoaXMgY29kZSwgbm90IHVzZSBnaXQuDQpTb3JyeSBhYm91dCB0aGF0LCBJJ2xsIGNoYW5nZSBi
YWNrIGFmdGVyIG91ciBkaXNjdXNzaW9uDQoNCi1Eb25nc2hlbmcNCj4gLVNjb3R0DQo+IA0KDQo=
