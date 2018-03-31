Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0bL0RRczF1rw
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:14 +1100 (AEDT)
In-Reply-To: <alpine.LNX.2.21.1803291117110.30@nippy.intranet>
To: Finn Thain <fthain@telegraphics.com.au>, Jiri Kosina <trivial@kernel.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: macintosh/adb: Use C99 initializers for struct adb_driver
 instances
Message-Id: <40D0bK43kZz9s44@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-29 at 00:36:04 UTC, Finn Thain wrote:
> No change to object files.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3a52f6f980c45b0dfa667f30d3ff03

cheers
