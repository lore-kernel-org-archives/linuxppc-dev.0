Return-Path: <madalin.bucur@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0131.outbound.protection.outlook.com [65.55.169.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F15681A0AD8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 18:16:21 +1000 (AEST)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Liberman Igal
 <Igal.Liberman@freescale.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc/fsl: Add FMan best effort port compatible
Date: Thu, 21 May 2015 08:16:14 +0000
Message-ID: <BL2PR03MB545098630EC3CC22F4427F6E6C10@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1431938519-11343-1-git-send-email-igal.liberman@freescale.com>
 <1431983358.27761.11.camel@freescale.com>
 <DM2PR03MB383ED154B2D6379219C60E8E6C30@DM2PR03MB383.namprd03.prod.outlook.com>
 <1432177461.27761.196.camel@freescale.com>
In-Reply-To: <1432177461.27761.196.camel@freescale.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gDQo+IFRoZSBjb21wYXRpYmxlIHN0cmluZyBzaG91bGQgZGVzY3JpYmUgd2hhdCBwcm9n
cmFtbWluZyBpbnRlcmZhY2UgaXMNCj4gcHJlc2VudC4gIE90aGVyIGluZm9ybWF0aW9uIHNob3Vs
ZCBiZSBpbiBvdGhlciBwcm9wZXJ0aWVzLiAgSGF2aW5nIHRoZQ0KPiBzYW1lIGNvbXBhdGlibGUg
Zm9yIHR4IGFuZCByeCBkZWZpbml0ZWx5IHNlZW1zIHdyb25nLg0KPiANCj4gLVNjb3R0DQo+IA0K
DQpIaSBTY290dCwgd2hhdCB3ZSB0cmllZCB0byBhY2NvbXBsaXNoIGhlcmUgaXMgdG8gYXZvaWQg
dXBkYXRpbmcgdS1ib290IGZvciB0aGlzIG5ldyBjb21wYXRpYmxlIGFuZCBoYXZlIG1pbmltYWwg
YWRkaXRpb25zIHRvIHRoZSBiaW5kaW5nIGRvY3VtZW50Lg0KDQpXZSBjdXJyZW50bHkga25vdyB0
aGF0Og0KDQoiZnNsLGZtYW4tdjMtcG9ydC1yeCIgIGlzIGFuIFJ4IHBvcnQgdGhhdCBjYW4gd29y
ayBpbiAxRyBtb2RlDQoiZnNsLGZtYW4tdjMtcG9ydC10eCIgIGlzIGFuIFR4IHBvcnQgdGhhdCBj
YW4gd29yayBpbiAxRyBtb2RlDQoNCldlIHByb3Bvc2VkIGFkZGluZyBhIG5ldyBvcHRpb25hbCBj
b21wYXRpYmxlICJmc2wsZm1hbi12My1iZXN0LWVmZm9ydC1wb3J0IiAgc3VjaCB0aGF0Og0KDQoi
ZnNsLGZtYW4tdjMtcG9ydC1yeCIgIGlzIGFuIFJ4IHBvcnQgdGhhdCBjYW4gd29yayBpbiAxRyBt
b2RlDQoiZnNsLGZtYW4tdjMtcG9ydC10eCIgIGlzIGFuIFR4IHBvcnQgdGhhdCBjYW4gd29yayBp
biAxRyBtb2RlDQoNCiJmc2wsZm1hbi12My1wb3J0LXJ4IiwgImZzbCxmbWFuLXYzLWJlc3QtZWZm
b3J0LXBvcnQiICBpcyBhbiBSeCBwb3J0IHRoYXQgY2FuIHdvcmsgaW4gMUcgbW9kZSBhbmQgYWxz
byBpbiBsaW1pdGVkIHJlc291cmNlZCAxMEcgbW9kZQ0KImZzbCxmbWFuLXYzLXBvcnQtdHgiLCAi
ZnNsLGZtYW4tdjMtYmVzdC1lZmZvcnQtcG9ydCIgIGlzIGFuIFR4IHBvcnQgdGhhdCBjYW4gd29y
ayBpbiAxRyBtb2RlIGFuZCBhbHNvIGluIGxpbWl0ZWQgcmVzb3VyY2VkIDEwRyBtb2RlDQoNClRo
ZSBvbmx5IGNvZGUgYWRkaXRpb24gcmVxdWlyZWQgaXMgaW4gdGhlIExpbnV4IGRyaXZlciwgY29k
ZSB0aGF0IGNoZWNrcyBmb3IgdGhlIG9wdGlvbmFsLCBzdXBwbGVtZW50YWwgcGFyYW1ldGVyICJm
c2wsZm1hbi12My1iZXN0LWVmZm9ydC1wb3J0IiB0byBjaGFuZ2Ugc29tZSByZXNvdXJjZSBhbGxv
Y2F0aW9ucy4NCg0KTWFkYWxpbg0K
