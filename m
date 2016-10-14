Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw7qX30f7zDt1l
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:33:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: simplify loop control in
 parse_numa_properties()
In-Reply-To: <1476384330-22654-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1476384330-22654-1-git-send-email-arbab@linux.vnet.ibm.com>
Date: Fri, 14 Oct 2016 11:33:12 +1100
Message-ID: <87bmynepmf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> The flow of the main loop in parse_numa_properties() is overly
> complicated. Simplify it to be less confusing and easier to read.
> No functional change.

I think you're right, but it's not obvious from the diff. Please explain
in more detail why the old and new code is equivalent.

cheers
