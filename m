Return-Path: <mmporter@cox.net>
Received: from fed1rmmtai19.cox.net (fed1rmmtai19.cox.net [68.230.241.40])
	by ozlabs.org (Postfix) with ESMTP id 315DE679F6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 09:48:37 +1000 (EST)
Date: Wed, 26 Apr 2006 16:35:40 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Stephen Williams <steve@icarus.com>
Subject: Re: PPC 405GPr support in linux 2.4.32
Message-ID: <20060426163540.H16236@cox.net>
References: <e2ov5s$1hn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e2ov5s$1hn$1@sea.gmane.org>;
	from steve@icarus.com on Wed, Apr 26, 2006 at 04:19:23PM -0700
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 26, 2006 at 04:19:23PM -0700, Stephen Williams wrote:
> ... seems completely missing in the linux-2.3.32 tree from kernel.org.
> This used to be in the linuxppc-2.4 BK tree that no longer exists, so
> what happened to the ppc405GPr support?!

There's some stuff that never got submitted upstream to kernel.org
during 2.4 due partially to 2.5 appearing. All upstream devel
moved to 2.5/2.6 and no effort was made to merge stuff from the
linuxppc-2.4 tree to linux-2.4. Oh, and Marcelo didn't want
to take "new stuff" into linux-2.4 at that time either.

There's still rsync://source.mvista.com/linuxppc-2.4 available with
the 405gpr/sycamore support.

-Matt
