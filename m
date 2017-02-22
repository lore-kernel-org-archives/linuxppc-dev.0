Return-Path: <tomas.winkler@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSqs50m0nzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:14:16 +1100 (AEDT)
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "gfree.wind@gmail.com" <gfree.wind@gmail.com>, "fgao@ikuai8.com"
 <fgao@ikuai8.com>, "rob@landley.net" <rob@landley.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH kernel 1/1] powerpc/Documentation/misc-devices/: Fix one
 compile error
Date: Wed, 22 Feb 2017 08:14:11 +0000
Message-ID: <1487751232.13163.24.camel@intel.com>
References: <1487748144-13685-1-git-send-email-fgao@ikuai8.com>
In-Reply-To: <1487748144-13685-1-git-send-email-fgao@ikuai8.com>
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

T24gV2VkLCAyMDE3LTAyLTIyIGF0IDE1OjIyICswODAwLCBmZ2FvQGlrdWFpOC5jb20gd3JvdGU6
DQo+IEZyb206IEdhbyBGZW5nIDxmZ2FvQGlrdWFpOC5jb20+DQo+IA0KPiBXaGVuIG1ha2UgYWxs
eWVzY29uZmlnLCB0aGVyZSBpcyBvbmUgY29tcGlsZSBlcnJvciBvbiBteSBwbGF0Zm9ybQ0KPiAi
Z2NjIChVYnVudHUgNC44LjQtMnVidW50dTF+MTQuMDQuMykgNC44LjQiLg0KPiBUaGUgZm9sbG93
aW5nIGlzIHRoZSBvdXRwdXQuDQo+IA0KPiBEb2N1bWVudGF0aW9uL21pc2MtZGV2aWNlcy9tZWkv
bWVpLWFtdC12ZXJzaW9uLmM6IEluIGZ1bmN0aW9uIOKAmG1haW7igJk6DQo+IERvY3VtZW50YXRp
b24vbWlzYy1kZXZpY2VzL21laS9tZWktYW10LXZlcnNpb24uYzoxMDM6NTogd2FybmluZzoNCj4g
4oCYYWNtZC5mZOKAmQ0KPiBpcyB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBb
LVd1bmluaXRpYWxpemVkXQ0KPiDCoCBpZiAoY2wtPmZkICE9IC0xKQ0KPiDCoMKgwqDCoMKgXg0K
PiBEb2N1bWVudGF0aW9uL21pc2MtZGV2aWNlcy9tZWkvbWVpLWFtdC12ZXJzaW9uLmM6NDQzOjIx
OiBub3RlOg0KPiDigJhhY21kLmZk4oCZDQo+IHdhcyBkZWNsYXJlZCBoZXJlDQo+IMKgIHN0cnVj
dCBhbXRfaG9zdF9pZiBhY21kOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBeDQo+IFRoaXMgY29tbWl0IGZpeGVzIHRoaXMgY29tcGlsZSBlcnJvci4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEdhbyBGZW5nIDxmZ2FvQGlrdWFpOC5jb20+DQoNClRoaXMgaXMgZmFs
c2UgcG9zaXRpdmUsIGFzIHRoZSB2YXJpYWJsZSBpcyBhc3NpbmVkIGluIG1laV9pbml0KCksIGlu
DQphbnkgY2FzZSwgdGhlIGNvZGUgaGFzIG1vdmVkIHVuZGVyIHNhbXBsZXMgZGlyZXRvcnkgaW4g
dGhlIGN1cnJlbnQNCmtlcm5lbC4gQW55dGhpbmcgbmVlZCB0byBiZSBmaXhlZCB0aGVyZSBmaXJz
dA0KDQpUaGFua3PCoA0KVG9tYXMNCg0KPiAtLS0NCj4gwqBEb2N1bWVudGF0aW9uL21pc2MtZGV2
aWNlcy9tZWkvbWVpLWFtdC12ZXJzaW9uLmMgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL21pc2MtZGV2aWNl
cy9tZWkvbWVpLWFtdC12ZXJzaW9uLmMNCj4gYi9Eb2N1bWVudGF0aW9uL21pc2MtZGV2aWNlcy9t
ZWkvbWVpLWFtdC12ZXJzaW9uLmMNCj4gaW5kZXggNDllNGY3Ny4uY2EwMzVjYiAxMDA2NDQNCj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9taXNjLWRldmljZXMvbWVpL21laS1hbXQtdmVyc2lvbi5jDQo+
ICsrKyBiL0RvY3VtZW50YXRpb24vbWlzYy1kZXZpY2VzL21laS9tZWktYW10LXZlcnNpb24uYw0K
PiBAQCAtMjk3LDYgKzI5Nyw3IEBAIHN0YXRpYyBib29sIGFtdF9ob3N0X2lmX2luaXQoc3RydWN0
IGFtdF9ob3N0X2lmDQo+ICphY21kLA0KPiDCoAkJwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBz
ZW5kX3RpbWVvdXQsIGJvb2wgdmVyYm9zZSkNCj4gwqB7DQo+IMKgCWFjbWQtPnNlbmRfdGltZW91
dCA9IChzZW5kX3RpbWVvdXQpID8gc2VuZF90aW1lb3V0IDogMjAwMDA7DQo+ICsJYWNtZC0+bWVp
X2NsLmZkID0gLTE7DQo+IMKgCWFjbWQtPmluaXRpYWxpemVkID0gbWVpX2luaXQoJmFjbWQtPm1l
aV9jbCwgJk1FSV9JQU1USElGLCAwLA0KPiB2ZXJib3NlKTsNCj4gwqAJcmV0dXJuIGFjbWQtPmlu
aXRpYWxpemVkOw0KPiDCoH0=
