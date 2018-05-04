Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0071.outbound.protection.outlook.com [104.47.36.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40csx56QYHzDqwb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 23:16:54 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH  12/17] powerpc/8xx: Remove PTE_ATOMIC_UPDATES
Date: Fri, 4 May 2018 13:16:47 +0000
Message-ID: <ed9a24137444d3af46031e95a5930bf085e121e7.camel@infinera.com>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
 <3ece8e0d69f3016111cdb9d643dfc4a158849ae0.1525435203.git.christophe.leroy@c-s.fr>
In-Reply-To: <3ece8e0d69f3016111cdb9d643dfc4a158849ae0.1525435203.git.christophe.leroy@c-s.fr>
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

T24gRnJpLCAyMDE4LTA1LTA0IGF0IDE0OjM0ICswMjAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBv
cmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4N
Cj4gDQo+IA0KPiBjb21taXQgMWJjNTRjMDMxMTdiOSAoInBvd2VycGM6IHJld29yayA0eHggUFRF
IGFjY2VzcyBhbmQgVExCIG1pc3MiKQ0KPiBpbnRyb2R1Y2VkIG5vbiBhdG9taWMgUFRFIHVwZGF0
ZXMgYW5kIHN0YXJ0ZWQgdGhlIHdvcmsgb2YgcmVtb3ZpbmcNCj4gUFRFIHVwZGF0ZXMgaW4gVExC
IG1pc3MgaGFuZGxlcnMsIGJ1dCBrZXB0IFBURV9BVE9NSUNfVVBEQVRFUyBmb3IgdGhlDQo+IDh4
eCB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWVudDoNCj4gLyogVW50aWwgbXkgcmV3b3JrIGlzIGZp
bmlzaGVkLCA4eHggc3RpbGwgbmVlZHMgYXRvbWljIFBURSB1cGRhdGVzICovDQo+IA0KPiBjb21t
aXQgZmUxMWRjM2Y5NjI4ZSAoInBvd2VycGMvOHh4OiBVcGRhdGUgVExCIGFzbSBzbyBpdCBiZWhh
dmVzIGFzIGxpbnV4DQo+IG1tIGV4cGVjdHMiKSByZW1vdmVkIGFsbCBQVEUgdXBkYXRlcyBkb25l
IGluIFRMQiBtaXNzIGhhbmRsZXJzDQoNCklzIHRoYXQgbXkgNyB5ZWFyIG9sZCBjb21taXQgPw0K
DQo+IA0KPiBUaGVyZWZvcmUsIGF0b21pYyBQVEUgdXBkYXRlcyBhcmUgbm90IG5lZWRlZCBhbnlt
b3JlIGZvciB0aGUgOHh4DQoNCkFib3V0IHRpbWUgcmVtb3ZpbmcgYXRvbWljIHVwZGF0ZXMgdGhl
biA6KQ0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhl
Lmxlcm95QGMtcy5mcj4NCj4gDQo=
