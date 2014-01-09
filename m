Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 281F02C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 23:08:17 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 0/4] powernv: kvm: numa fault improvement
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Thu, 9 Jan 2014 13:08:09 +0100
Message-Id: <DB55CAD2-72AF-4740-9904-193071C2740B@suse.de>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.12.2013, at 09:47, Liu Ping Fan <kernelfans@gmail.com> wrote:

> This series is based on Aneesh's series  "[PATCH -V2 0/5] powerpc: mm: =
Numa faults support for ppc64"
>=20
> For this series, I apply the same idea from the previous thread =
"[PATCH 0/3] optimize for powerpc _PAGE_NUMA"
> (for which, I still try to get a machine to show nums)
>=20
> But for this series, I think that I have a good justification -- the =
fact of heavy cost when switching context between guest and host,
> which is  well known.

This cover letter isn't really telling me anything. Please put a proper =
description of what you're trying to achieve, why you're trying to =
achieve what you're trying and convince your readers that it's a good =
idea to do it the way you do it.

> If my suppose is correct, will CCing kvm@vger.kernel.org from next =
version.

This translates to me as "This is an RFC"?


Alex
