Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 243ED679FD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 May 2005 06:38:21 +1000 (EST)
Date: Tue, 24 May 2005 13:38:19 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: ming lei <mlei30@yahoo.com>
Message-ID: <20050524133819.B23084@cox.net>
References: <20050524183650.16871.qmail@web61017.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050524183650.16871.qmail@web61017.mail.yahoo.com>;
	from mlei30@yahoo.com on Tue, May 24, 2005 at 11:36:50AM -0700
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MMUCR on ppc440 GP/GX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, May 24, 2005 at 11:36:50AM -0700, ming lei wrote:
> 
> what's the latest ppc440 linux code that I can take
> look at?

Grab the current kernel.org 2.6 release. I suggest you use
dirdiff another recent 2.4 kernel and then analyze the 2.6 stuff
as it is different yet.  There are countless bug fixes that have
gone in over the last 3 years.  I sincerely hope you aren't
trying to use that old kernel with experimental PPC440 support
for production work.
 
> BTW, what's the problem three years ago prompted to
> change the code regarding mmucr handling?

The problem was that the initial code would crash apps regularly. I
put the code out in our development tree at the time since it was
taking a long time to find the bug...and you could mostly run a
system.  The MMUCR was not having the TID set properly during
a tlbie() and a couple other spots in head_440.S.

-Matt
