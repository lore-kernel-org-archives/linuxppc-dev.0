Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id EE9142C0079
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 08:31:11 +1000 (EST)
Subject: Re: [PATCH -V3 2/4] powerpc/kvm: Contiguous memory allocator based
 hash page table allocation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372804109.4122.25.camel@pasglop>
Date: Wed, 3 Jul 2013 00:31:05 +0200
Message-Id: <1ED23E51-19E6-4AA7-B241-937845877607@suse.de>
References: <1372743918-12293-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1372743918-12293-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <51D2EDD7.9060205@suse.de> <1372804109.4122.25.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, mina86@mina86.com,
 linux-mm@kvack.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.2013, at 00:28, Benjamin Herrenschmidt wrote:

> On Tue, 2013-07-02 at 17:12 +0200, Alexander Graf wrote:
>> Is CMA a mandatory option in the kernel? Or can it be optionally=20
>> disabled? If it can be disabled, we should keep the preallocated=20
>> fallback case around for systems that have CMA disabled.
>=20
> Why ? More junk code to keep around ...
>=20
> If CMA is disabled, we can limit ourselves to dynamic allocation (with
> limitation to 16M hash table).

Aneesh adds a requirement for CMA on the KVM option in Kconfig, so all =
is well.


Alex
