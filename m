Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17FD11A0CF5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Nov 2015 09:55:58 +1100 (AEDT)
Date: Fri, 6 Nov 2015 16:55:49 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Laurent Vivier <laurent@vivier.eu>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: allow cross-compilation of ppc64 kernel
Message-ID: <20151106225549.GA21395@gate.crashing.org>
References: <1446724029-10884-1-git-send-email-laurent@vivier.eu>
 <1446844180.11597.13.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446844180.11597.13.camel@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 06, 2015 at 03:09:40PM -0600, Scott Wood wrote:
> Why is GCC building ppc64 object files but telling the linker --oformat elf32-
> powerpcle?  Are different options somehow being passed to GCC in one case 
> versus the other?

This was changed for GCC 6 in <http://gcc.gnu.org/r227397>, could one of
you check if that fixes this problem?  If so we'll need to backport it.


Segher
