Return-Path: <xuelin.shi@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 16F45140093
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:08:07 +1000 (EST)
From: Xuelin Shi <xuelin.shi@freescale.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH v3] dmaengine: driver support for FSL RaidEngine device.
Date: Tue, 15 Apr 2014 03:07:59 +0000
Message-ID: <59bafd921a7e4a59bcf1910cfa2ec1ed@BL2PR03MB147.namprd03.prod.outlook.com>
References: <1397202086-22489-1-git-send-email-xuelin.shi@freescale.com>
 <CAA9_cme=Bo3tYi0-bNXBRNLZnC-4FZyaSYZ=3iRD_5xfiVX5Mw@mail.gmail.com>
 <0c8d1963a25648f8a8f820bbc55afe4f@BL2PR03MB147.namprd03.prod.outlook.com>
 <CAPcyv4go1ghjD7fiEzwPJmcjRMBv7p0t7Sm9Ki=1Hu-0GKqoCQ@mail.gmail.com>
In-Reply-To: <CAPcyv4go1ghjD7fiEzwPJmcjRMBv7p0t7Sm9Ki=1Hu-0GKqoCQ@mail.gmail.com>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: Harninder Rai <harninder.rai@freescale.com>,
 "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, Naveen Burmi <NaveenBurmi@freescale.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

WWVzLCAiZGVwZW5kIG9uICFBU1lOQ19UWF9DSEFOTkVMX1NXSVRDSCIgaXMgYmV0dGVyIHNpbmNl
IGZzbGRtYSBzZWxlY3RzIHRoaXMgY29uZGl0aW9uLg0KDQpUaGFua3MsDQpYdWVsaW4gU2hpDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYW4gV2lsbGlhbXMgW21haWx0bzpk
YW4uai53aWxsaWFtc0BpbnRlbC5jb21dIA0KU2VudDogMjAxNMTqNNTCMTXI1SA4OjMwDQpUbzog
U2hpIFh1ZWxpbi1CMjkyMzcNCkNjOiBLb3VsLCBWaW5vZDsgYW5kcml5LnNoZXZjaGVua29AaW50
ZWwuY29tOyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51eHBwYy1kZXY7IFJhaSBIYXJu
aW5kZXItQjAxMDQ0OyBCdXJtaSBOYXZlZW4tQjE2NTAyDQpTdWJqZWN0OiBSZTogW1BBVENIIHYz
XSBkbWFlbmdpbmU6IGRyaXZlciBzdXBwb3J0IGZvciBGU0wgUmFpZEVuZ2luZSBkZXZpY2UuDQoN
Ck9uIFN1biwgQXByIDEzLCAyMDE0IGF0IDc6NDggUE0sIFh1ZWxpbiBTaGkgPHh1ZWxpbi5zaGlA
ZnJlZXNjYWxlLmNvbT4gd3JvdGU6DQo+IEhpIERhbiwNCj4NCj4gZnNsIGRtYSBkZXZpY2UgYW5k
IGZzbCByYWlkIGRldmljZSBhcmUgdHdvIGRpZmZlcmVuY3QgZGV2aWNlcyB0aGF0IA0KPiBib3Ro
IHByb3ZpZGUgYXN5bmNfbWVtY3B5IGNhcGFiaWxpdHksIHNvIEkgdXNlICFGU0xfRE1BIHRvIGRp
c2FibGUgdGhlIGZzbCBkbWEgZGV2aWNlLg0KPg0KPiBUaGF0J3MgdG8gc2F5LCBlaXRoZXIgc2Vs
ZWN0IGZzbGRtYSBkZXZpY2UsIGVpdGhlciBmc2wgcmFpZCBkZXZpY2UuDQo+DQoNClJpZ2h0LCBi
dXQgdGhhdCdzIG5vdCB3aGF0IHlvdXIgcHJvcG9zZWQgS2NvbmZpZyBkZXBlbmRlbmN5IGxpbmUg
ZG9lcy4NCg0KWW91IHdhbnQgc29tZXRoaW5nIGxpa2UgImRlcGVuZHMgb24gRlNMX1NPQyAmJiAh
KEZTTF9ETUEgfHwgRlNMX0RNQT1tKSINCg0KSG93ZXZlciwgdGhlIG1vcmUgcHJvYmxlbWF0aWMg
b3B0aW9uIGlzIEFTWU5DX1RYX0NIQU5ORUxfU1dJVENILiAgVGhhdCBvcHRpb24gaXMgcHJvYmxl
bWF0aWMgZm9yIFJBSUQsIHNvIEkgcHJvcG9zZSAiZGVwZW5kIG9uICFBU1lOQ19UWF9DSEFOTkVM
X1NXSVRDSCIgc2luY2UgdGhhdCBhZGRyZXNzZXMgYm90aCBwcm9ibGVtcy4NCg0KDQo=
