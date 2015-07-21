Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B44291A01C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 20:00:18 +1000 (AEST)
In-Reply-To: <1437461926-8908-7-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [RFC, 7/8] powerpc/xmon: Drop 'valid' from the condition inside
 'dump_segments'
Message-Id: <20150721100018.98F93140DBC@ozlabs.org>
Date: Tue, 21 Jul 2015 20:00:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-21-07 at 06:58:45 UTC, Anshuman Khandual wrote:
> From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
> 
> Value of 'valid' is zero when 'esid' is zero and it does not matter
> when 'esid' is non-zero. 

Yes it does. It tells you whether the entry is valid?

In practice maybe you only see invalid entries that are entirely zero, and so
they get skipped anyway, but that's not guaranteed.

cheers
