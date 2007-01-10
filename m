Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17828.19395.906600.586578@cargo.ozlabs.ibm.com>
Date: Wed, 10 Jan 2007 13:13:23 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: Updates for CPM2 pic
In-Reply-To: <20070110011124.20342.38130.stgit@localhost.localdomain>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug writes:
> 
> This contains important fixes for the CPM2 PIC code. Eliminated
> CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the interrupt
> mapping. Updated devicetree files to reflect that. Changed direct
> IC-related IO accesses to the IO accessors.

I can't put these patches in for 2.6.20 with the titles and
descriptions you have given.

At this stage, for stuff to go into 2.6.20, you need to clearly
identify what the problem is that you're fixing and give at least some
indication of why it needs to be fixed for 2.6.20.  If the code
currently won't compile at all for some config, or is now completely
wrong because of changes elsewhere, or could cause an oops, then we
can fix it, but I need something better than just "Updates" in the
title and a list of what changes you made in the description.  At the
moment I look at your patch titles and descriptions and think "that's
nice, but why should it go in 2.6.20?"

If you're fixing up something that worked in 2.6.19 but now doesn't
work, that helps justify the change, but you need to say that.

These comments apply particularly to patches 1 to 3 in your series.
For patch 4/5 you at least told us that changes to io.h caused the
breakage, but even there a bit more detail about what changes caused
what breakage would be useful.  However, at this stage, you need to
resist the temptation to do other "overhaul and improvements" while
you are there; just fix the bugs or breakages that you have identified
in the description.

Patch 5/5 is OK since it doesn't touch any actual code.

Paul.
