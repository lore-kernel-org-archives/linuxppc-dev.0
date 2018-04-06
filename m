Return-Path: <tony.luck@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HkZf6fndzF1yb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 01:46:34 +1000 (AEST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
CC: Jeff Moyer <jmoyer@redhat.com>, Matthew Wilcox <mawilcox@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm
 <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>
Subject: RE: [RESEND 2/3] powerpc/memcpy: Add memcpy_mcsafe for pmem
Date: Fri, 6 Apr 2018 15:46:30 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B3C797F@ORSMSX110.amr.corp.intel.com>
References: <20180404231943.29581-1-bsingharora@gmail.com>
 <20180404231943.29581-3-bsingharora@gmail.com>
 <20180405095755.58b3891f@roar.ozlabs.ibm.com>
 <CAPcyv4hqKsOy9GU=NcMGj38pXnuEMRhXfox6jVwQ37+mcjnvhA@mail.gmail.com>
 <20180405150405.5b902b41@roar.ozlabs.ibm.com>
 <20180405155307.49f748f3@gmail.com>
 <20180405164508.7a15a770@roar.ozlabs.ibm.com>
 <x496055gzet.fsf@segfault.boston.devel.redhat.com>
 <20180406112600.454432f0@roar.ozlabs.ibm.com>
 <CAKTCnz=LD_uO7bdwFHDHy9KHHJ_dPA1LdxF1Pm7OUFFGr4s_VA@mail.gmail.com>
In-Reply-To: <CAKTCnz=LD_uO7bdwFHDHy9KHHJ_dPA1LdxF1Pm7OUFFGr4s_VA@mail.gmail.com>
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

PiBJIHRob3VnaHQgdGhlIGNhY2hlLWFsaWduZWQgbWlnaHQgbWFrZSBzZW5zZSwgc2luY2UgdXN1
YWxseSB3ZSdkIGV4cGVjdCB0aGUNCj4gZmFpbHVyZSB0byBiZSBhdCBhIGNhY2hlLWxpbmUgbGV2
ZWwsIGJ1dCBvdXIgY29weV90b2Zyb21fdXNlciBkb2VzIGFjY3VyYXRlDQo+IGFjY291bnRpbmcN
Cg0KVGhhdCdzIG9uZSBvZiB0aGUgd3JpbmtsZXMgaW4gdGhlIGN1cnJlbnQgeDg2IG1lbWNweV9t
Y3NhZmUoKS4gSXQgc3RhcnRzIGJ5DQpjaGVja2luZyBhbGlnbm1lbnQgb2YgdGhlIHNvdXJjZSBh
ZGRyZXNzLCBhbmQgbW92ZXMgYSBieXRlIGF0IGEgdGltZSB1bnRpbA0KaXQgaXMgOC1ieXRlIGFs
aWduZWQuIFdlIGRvIHRoaXMgYmVjYXVzZSBjdXJyZW50IHg4NiBpbXBsZW1lbnRhdGlvbnMgZG8g
bm90DQpncmFjZWZ1bGx5IGhhbmRsZSBhbiB1bmFsaWduZWQgcmVhZCB0aGF0IHNwYW5zIGZyb20g
YSBnb29kIGNhY2hlLWxpbmUgaW50bw0KYSBwb2lzb25lZCBvbmUuDQoNClRoaXMgaXMgZGlmZmVy
ZW50IGZyb20gY29weV90b2Zyb21fdXNlciB3aGljaCBhbGlnbnMgdGhlIGRlc3RpbmF0aW9uIGZv
ciBzcGVlZA0KcmVhc29ucyAodW5hbGlnbmVkIHJlYWRzIGhhdmUgYSBsb3dlciBwZW5hbHR5IHRo
YW4gdW5hbGlnbmVkIHdyaXRlcykuDQoNCi1Ub255DQo=
