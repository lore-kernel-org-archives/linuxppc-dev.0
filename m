Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id ADBD42BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Oct 2004 22:31:02 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Sun, 17 Oct 2004 05:30:45 -0700
To: linuxppc-embedded@ozlabs.org
Message-ID: <20041017123045.GA25808@xyzzy>
References: <BCEFJBPJCGFCNMMMIDBHMEIKCIAA.Joakim.Tjernlund@lumentis.se>
	<Pine.LNX.4.60.0410141824300.24365@localhost.localdomain>
	<20041014224128.GE19791@smtp.west.cox.net>
	<Pine.LNX.4.60.0410170702410.3826@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0410170702410.3826@localhost.localdomain>
Subject: Re: Merge 8xx to Linus tree?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sun, Oct 17, 2004 at 11:03:52AM +0000, Robert P. J. Day wrote:
> > Once upstream, new changes won't (unless not-fully-baked) go into
> > linuxppc-2.5.
> 
> um ... sorry, i'm still not sure what this means.  does it mean that,
> at some point (to be determined/announced?), the linuxppc-2.5 tree
> will be put to the side, and all further mods should be done directly
> against the 2.5 tree?

Yes, that's already the case for most ppc platforms.  The only thing
that keeps it from being true for 8xx is that it doesn't work yet
in the linux-2.5 tree.

-Dale
