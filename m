Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0D5D1A02AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 05:42:49 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH v3] KVM: PPC: e500mc: Enhance tlb invalidation condition
 on vcpu schedule
Date: Tue, 17 Jun 2014 19:42:41 +0000
Message-ID: <37af68eb6855437892a438eec213d788@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1403032176-28362-1-git-send-email-mihai.caraman@freescale.com>
 <1403032706.6603.776.camel@snotra.buserror.net>
In-Reply-To: <1403032706.6603.776.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+IC1zdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0IGt2bV92Y3B1ICosIGxhc3RfdmNwdV9v
bl9jcHUpOw0KPiA+ICtzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0IGt2bV92Y3B1ICogW0tW
TVBQQ19OUl9MUElEU10sDQo+IGxhc3RfdmNwdV9vbl9jcHUpOw0KPiANCj4gSG1tLCBJIGRpZG4n
dCBrbm93IHlvdSBjb3VsZCBleHByZXNzIHR5cGVzIGxpa2UgdGhhdC4gIElzIHRoaXMgc3BlY2lh
bA0KPiBzeW50YXggdGhhdCBvbmx5IHdvcmtzIGZvciB0eXBlb2Y/DQoNClllcywgQUZBSUsuDQoN
Cj4gTm8gc3BhY2UgYWZ0ZXIgKg0KDQpDaGVja3BhdGNoIGNvbXBsYWlucyBhYm91dCB0aGUgbWlz
c2luZyBzcGFjZSA7KQ0KDQo+IA0KPiBOYW1lIHNob3VsZCBiZSBhZGp1c3RlZCB0byBtYXRjaCwg
c29tZXRoaW5nIGxpa2UgbGFzdF92Y3B1X29mX2xwaWQgKHdpdGgNCj4gdGhlIF9vbl9jcHUgYmVp
bmcgaW1wbGllZCBieSB0aGUgZmFjdCB0aGF0IGl0J3MgUEVSX0NQVSkuDQoNCkkgd2FzIHRoaW5r
aW5nIHRvIHRoZSBsb25nIG5hbWUgYnV0IGl0IHdhcyBub3QgYXBwZWFsaW5nLCBJIHdpbGwgY2hh
bmdlIGl0IHRvDQpsYXN0X3ZjcHVfb2ZfbHBpZC4NCg0KLU1pa2UNCg==
