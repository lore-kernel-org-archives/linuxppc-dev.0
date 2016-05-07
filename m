Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1wGl0ZXBzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 May 2016 14:12:47 +1000 (AEST)
In-Reply-To: <20160506115108.26330.38061.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/3] powerpc/fadump: add support for fadump_nr_cpus= parameter
Message-Id: <3r1wGk6H7Yz9t3k@ozlabs.org>
Date: Sat,  7 May 2016 14:12:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-06-05 at 11:51:08 UTC, Hari Bathini wrote:
> Kernel parameter 'nr_cpus' can be used to limit the maximum number
> of processors that an SMP kernel could support. This patch extends
> this to fadump by introducing 'fadump_nr_cpus' parameter that can
> help in booting fadump kernel on a lower memory footprint.

Is there really no other way to do this? I really hate adding new, single use
only command line parameters.

cheers
