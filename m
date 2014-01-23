Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0154.outbound.protection.outlook.com [207.46.163.154])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 108972C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 14:00:33 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 3/3] powerpc/fsl: Use the new interface to save or
 restore registers
Date: Thu, 23 Jan 2014 03:00:25 +0000
Message-ID: <b9258b5f10554453a81cb9065a9bd5ac@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-3-git-send-email-dongsheng.wang@freescale.com>
 <1389742224.24905.140.camel@snotra.buserror.net>
 <93a6a30cd8d240109405d45c8e143dea@BN1PR03MB188.namprd03.prod.outlook.com>
 <1389842143.24905.195.camel@snotra.buserror.net>
 <18d3109ac114477a805618829632b463@BN1PR03MB188.namprd03.prod.outlook.com>
 <1390422892.24905.512.camel@snotra.buserror.net>
In-Reply-To: <1390422892.24905.512.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "anton@enomsg.org" <anton@enomsg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+IEN1cnJlbnRseSBkb2VzIG5vdCBzdXBwb3J0LiBvayBjaGFuZ2UgdGhlIG5hbWUgZmlyc3Qs
IGlmIGxhdGVyIHN1cHBvcnQsIGFuZA0KPiA+IHRoZW4gYWdhaW4gdG8gbW9kaWZ5IHRoZSBuYW1l
IG9mIHRoaXMgZnVuY3Rpb24uDQo+ID4NCj4gPiBIb3cgYWJvdXQgODV4eF9jcHVfc3RhdGVfcmVz
dG9yZT8NCj4gDQo+IFN5bWJvbHMgY2FuJ3QgYmVnaW4gd2l0aCBudW1iZXJzLiAgYm9va2VfY3B1
X3N0YXRlX3Jlc3RvcmUgd291bGQgYmUNCj4gYmV0dGVyIChpdCB3b3VsZCBzdGlsbCBwcm92aWRl
IGEgcGxhY2UgZm9yIDQ0eCB0byBiZSBhZGRlZCBpZiBzb21lYm9keQ0KPiBhY3R1YWxseSBjYXJl
ZCBhYm91dCBkb2luZyBzbykuDQo+IA0KOikuIFRoYW5rcy4NCg0KLURvbmdzaGVuZw0KDQo=
