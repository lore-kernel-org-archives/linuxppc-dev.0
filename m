Return-Path: <Eric.Moore@lsi.com>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78CE31007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 08:06:04 +1000 (EST)
From: "Moore, Eric" <Eric.Moore@lsi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 18 May 2011 16:05:58 -0600
Subject: RE: [PATCH 1/3] mpt2sas: remove the use of writeq, since writeq is
	not atomic
Message-ID: <4565AEA676113A449269C2F3A549520F80BE7FAF@cosmail03.lsi.com>
References: <20110504115324.GE17855@lsi.com>
	<1305616571.6008.23.camel@mulgrave.site>
	<B2FD678A64EAAD45B089B123FDFC3ED70157F7BCE5@inbmail01.lsi.com>
	<20110518041551.GL15227@parisc-linux.org>
	<1305692584.2580.3.camel@mulgrave.site>	<1305702010.2781.33.camel@pasglop>
	<mpt2sas-writeq-powerpc64@mdm.bga.com>
	<4565AEA676113A449269C2F3A549520F80B66280@cosmail03.lsi.com>
	<1305754218.7481.0.camel@pasglop>
In-Reply-To: <1305754218.7481.0.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "Prakash, Sathya" <Sathya.Prakash@lsi.com>, "Desai,
	Kashyap" <Kashyap.Desai@lsi.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Matthew Wilcox <matthew@wil.cx>, Milton Miller <miltonm@bga.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	"paulus@samba.org" <paulus@samba.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

T24gV2VkbmVzZGF5LCBNYXkgMTgsIDIwMTEgMzozMCBQTSwgQmVuamFtaW4gSGVycmVuc2NobWlk
dCB3cm90ZToNCj4gDQo+IFlvdSBtYXkgYWxzbyB3YW50IHRvIGxvb2sgYXQgTWlsdG9uJ3MgY29t
bWVudHMsIGl0IGxvb2tzIGxpa2UgdGhlIHdheQ0KPiB5b3UgZG8gaW5pdF9jb21wbGV0aW9uIGZv
bGxvd2VkIGltbWVkaWF0ZWx5IGJ5IHdhaXRfY29tcGxldGlvbiBpcyByYWN5Lg0KPiANCj4gWW91
IHNob3VsZCBpbml0IHRoZSBjb21wbGV0aW9uIGJlZm9yZSB5b3UgZG8gdGhlIElPIHRoYXQgd2ls
bCBldmVudHVhbGx5DQo+IHRyaWdnZXIgY29tcGxldGUoKSB0byBiZSBjYWxsZWQuDQo+IA0KDQpJ
IGFncmVlLiAgVGhlIGluaXRfY29tcGxldGlvbiBuZWVkcyB0byBiZSBkb25lIHByaW9yIHRvIHBv
c3RpbmcgdGhlIHNtaWQuICBJJ20gbm90IHN1cmUgd2h5IEkgZGlkIGl0IHRoYXQgd2F5Lg0K
