Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1Y60PNzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:33 +1100 (AEDT)
In-Reply-To: <20161103051542.GB8368@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [2/2] powerpc/64: Use optimized checksum routines on little-endian
Message-Id: <3v8g1Y4QQTz9t0t@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:33 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-11-03 at 05:15:42 UTC, Paul Mackerras wrote:
> Currently we have optimized hand-coded assembly checksum routines
> for big-endian 64-bit systems, but for little-endian we use the
> generic C routines.  This modifies the optimized routines to work
> for little-endian.  With this, we no longer need to enable
> CONFIG_GENERIC_CSUM.  This also fixes a couple of comments
> in checksum_64.S so they accurately reflect what the associated
> instruction does.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d4fde568a34a93897dfb9ae64cfe9d

cheers
