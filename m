Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id BE42B2BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 01:49:01 +1000 (EST)
Date: Mon, 4 Oct 2004 08:48:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Message-ID: <20041004084858.B11487@home.com>
References: <Pine.LNX.4.60.0410041110320.13645@dell.enoriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410041110320.13645@dell.enoriver.com>;
	from rpjday@mindspring.com on Mon, Oct 04, 2004 at 11:24:24AM
	-0400
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: what is the protocol for getting patches into the tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 04, 2004 at 11:24:24AM -0400, Robert P. J. Day wrote:
>    *what* does it take to get a patch into the bk-managed kernel source 
> tree at http://ppc.bkbits.net:8080/linuxppc-2.5.  originally, as i was 
> learning the ropes here and started to make suggestions, i was told, 
> in no uncertain terms, to "submit a patch".

<snip>

>    is this even the right place for such patches?  or should i be 
> submitting to the LKML list proper?  or what?  i'm more than willing 
> to follow the instructions for doing this the right way, i just need 
> to know what the right way is.

LKML has no interest in a patch which is only intended for a
PPC-only tree (i.e. linuxppc-2.5)

linuxppc-2.5/MAINTAINERS:

LINUX FOR POWERPC EMBEDDED PPC8XX AND BOOT CODE
P:      Tom Rini
M:      trini@kernel.crashing.org
W:      http://www.penguinppc.org/
L:      linuxppc-embedded@lists.linuxppc.org
S:      Maintained

PPC embedded only patches belong here...yes these ML references should
be updated to ozlabs.org.  cc: Tom since he is the 8xx maintainer.

<snip>

> i can submit sizable patches that try to do several related things 
> at once, or i can do it two lines at a time.  given the standard 
> protocol over at LKML, am i expected to just keep submitting the same 
> patch over and over, again and again, repeatedly, until it gets in? 
> some guidance here would be appreciated.  is there a code word?  a 
> secret handshake?  what?

Yes, submit it over and over until there is some feedback. argue
or follow the feedback...eventually it will go in unless it's not
a desirable change. If no feedback, keep submitting until the
maintainer has time to look at it.
 
-Matt
