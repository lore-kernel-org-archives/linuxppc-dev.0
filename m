Return-Path: <prvs=689f336f6=Bart.VanAssche@wdc.com>
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411cZF070LzF32f
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 17:27:32 +1000 (AEST)
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "vrbagal1@linux.vnet.ibm.com" <vrbagal1@linux.vnet.ibm.com>
CC: "sachinp@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Subject: Re: Fwd: [powerpc/Baremetal]Kernel OOPS while executing memory
 hotplug on Power8 baremetal
Date: Thu, 7 Jun 2018 07:16:50 +0000
Message-ID: <d5b62afc48ece5aca8d08a80871c8613dd555d17.camel@wdc.com>
References: <ee45ead1d96ad05f77aec1d8d3e39c85@linux.vnet.ibm.com>
In-Reply-To: <ee45ead1d96ad05f77aec1d8d3e39c85@linux.vnet.ibm.com>
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

T24gVGh1LCAyMDE4LTA2LTA3IGF0IDEyOjM4ICswNTMwLCB2cmJhZ2FsMSB3cm90ZToNCj4gT2Jz
ZXJ2aW5nIEtlcm5lbCBvb3BzIGFuZCBtYWNoaW5lIHJlYm9vdHMgd2hpbGUgZXhlY3V0aW5nIG1l
bW9yeSBob3RwbHVnIA0KPiB0ZXN0IGNhc2UsIG9uIFBvd2VyOCBCYXJlbWV0YWwgbWFjaGluZS4N
Cj4gDQo+IEkgc2VlIHRoaXMgaXMgaW50cm9kdWNlZCBzb21lIHdoZXJlIGJldHdlZW4gcmM2IGFu
ZCA0LjE3Lg0KDQpQbGVhc2UgcHJvdmlkZSB0aGUgZXhhY3QgdmVyc2lvbnMgKGdpdCBjb21taXQg
SURzKSBvZiB0aGUga2VybmVsIHZlcnNpb25zDQp5b3UgaGF2ZSB0ZXN0ZWQuDQoNClRoYW5rcywN
Cg0KQmFydC4NCg0KDQoNCg0K
