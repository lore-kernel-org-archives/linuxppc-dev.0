Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id EA98267A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Mar 2005 08:58:53 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Sat, 5 Mar 2005 14:58:39 -0700
To: Sven Luther <sven.luther@wanadoo.fr>
Message-ID: <20050305215839.GA16904@xyzzy>
References: <41F6E0E1.6000803@mvista.com> <20050224082508.GA30005@pegasos>
	<421DF2B8.6040007@mvista.com> <20050224160411.GA11197@pegasos>
	<20050224172420.GA6932@xyzzy> <20050305192752.GA28491@pegasos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050305192752.GA28491@pegasos>
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] mv64x60 updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Mar 05, 2005 at 08:27:52PM +0100, Sven Luther wrote:
> On Thu, Feb 24, 2005 at 10:24:20AM -0700, Dale Farnsworth wrote:
> > All of my changes to the mv643xx ethernet driver have been posted to
> > LKML or the netdev list.  I have removed all arch-specific code from
> > the ethernet driver itself.
> 
> What is the status of this with regard to the 2.6.11 mainline kernel ?

I'm hopeful they will go in this week to make 2.6.12

> > See bk://dfarnsworth.bkbits.net/linux-2.5-mv643xx-enet
> 
> I guess i need to look there, as in mainline 2.6.11, there doesn't seem to be
> direct related code between the ppc specific mv64x60 stuff, and the mips
> related ethernet one.

Yes.

> Well, as i am doing the powerpc debian 2.6.11 kernel, i really would like to
> port your work to the pegasos, but what i have seen from the code in the
> mainline kernel doesn't really make sense.

Benh also mentioned porting it to pegasos, but I haven't heard that he's
gotten to it.

-Dale
