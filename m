Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 38B9D1A03D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 13:16:24 +1100 (AEDT)
Message-ID: <54DABB77.1060003@ozlabs.org>
Date: Wed, 11 Feb 2015 10:16:23 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/boot/wrapper: use the pseries wrapper for
 zImage.epapr
References: <1423570510.218746.573015373614.2.gpush@pablo>
 <1423620754.5891.32.camel@kernel.crashing.org>
In-Reply-To: <1423620754.5891.32.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

>> We'll likely be entering the zImage.epapr as BE, so include the pseries
>> implementation of _zimage_start, which adds the endian fixup magic.
> 
> Wont that break embedded epapr stuff ?

How so? This will just give us the endian fixup trampoline (followed by
a branch to _zimage_start_lib) as the entry point, rather than directly
entering _zimage_start_lib. Will that not work on embedded?

Cheers,


Jeremy
