Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r57nd42JLzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 20:02:13 +1000 (AEST)
In-Reply-To: <1463041596-1845-1-git-send-email-bharata@linux.vnet.ibm.com>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: nfont@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 aik@au1.ibm.com, david@gibson.dropbear.id.au
Subject: Re: [FIX,v1] powerpc,numa: Fix memory_hotplug_max()
Message-Id: <3r57nd2V60z9t7G@ozlabs.org>
Date: Thu, 12 May 2016 20:02:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-05 at 08:26:36 UTC, Bharata B Rao wrote:
> memory_hotplug_max() uses hot_add_drconf_memory_max() to get maxmimum
> addressable memory by referring to ibm,dyanamic-memory property. There
> are three problems with the current approach:
...
> 
> NOTE: There are some unnecessary changes in the patch because of converting
> spaces to tabs w/o which checkpatch.pl complains.

OK. You don't always have to listen to checkpatch :)

Please split this into two patches, one that fixes the whitespace problems in
the function, and then a second one which makes your changes.

cheers
