Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60n2zWvzDvNL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:17 +1100 (AEDT)
In-Reply-To: <20161117163810.7355.74279.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/pseries: Correct possible read beyond dlpar sysfs buffer
Message-Id: <3tN60m6ZLpz9t0p@ozlabs.org>
Date: Tue, 22 Nov 2016 11:34:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-11-17 at 16:38:10 UTC, Nathan Fontenot wrote:
> The pasrsing of data written to the dlpar file in sysfs does not correctly
> account for the possibility of reading past the end of the buffer. The code
> assumes that all pieces of the command witten to the sysfs file are present
> in the form "<resource> <action> <id_type> <id>".
> 
> Correct this by updating the buffer parsing code to make a local copy and
> use the strsep() and sysfs_streq() routines to parse the buffer. This patch
> also separates the parsing code into subroutines for each piece of the
> command.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/25b587fba9a4198e7ea2e2319d62e2

cheers
