Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ACAE7B70BF
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Oct 2011 15:02:07 +1100 (EST)
Subject: Re: [PATCH] powerpc/85xx: Setup secondary cores PIR with hard SMP id
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B8D6CA50DACE9E4AAADE9A4D56FBAAE6244FDF@039-SN1MPN1-005.039d.mgd.msft.net>
Date: Wed, 19 Oct 2011 23:02:15 -0500
Message-Id: <C79C8827-F6FE-42E0-8FAF-E62A8FFD6A1F@kernel.crashing.org>
References: <1318578771-16865-1-git-send-email-galak@kernel.crashing.org>
 <B8D6CA50DACE9E4AAADE9A4D56FBAAE6244FDF@039-SN1MPN1-005.039d.mgd.msft.net>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 19, 2011, at 10:53 PM, Bhushan Bharat-R65777 wrote:

> 
> 
>> -----Original Message-----
>> From: linuxppc-dev-bounces+bharat.bhushan=freescale.com@lists.ozlabs.org
>> [mailto:linuxppc-dev-
>> bounces+bharat.bhushan=freescale.com@lists.ozlabs.org] On Behalf Of Kumar
>> Gala
>> Sent: Friday, October 14, 2011 1:23 PM
>> To: linuxppc-dev@ozlabs.org
>> Subject: [PATCH] powerpc/85xx: Setup secondary cores PIR with hard SMP id
>> 
>> Normally logical and hard cpu ID are the same, however in same cases like
>> on the P3060 they may differ.  Where the logical is 0..5, the hard id
>> goes 0,1,4..7.  This can causes issues for places we utilize PIR to index
>> into array like in debug exception handlers for finding the exception
>> stack.
> 
> Kumar, What should be the CONFIG_NR_CPUS for this? 8 or 6 ?

8.

- k
