Return-Path: <jonmasters@gmail.com>
Received: from mproxy.gmail.com (rproxy.gmail.com [64.233.170.192])
	by ozlabs.org (Postfix) with ESMTP id 0EADE2BDB0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Oct 2004 07:54:50 +1000 (EST)
Received: by mproxy.gmail.com with SMTP id 76so4672409rnk
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 01 Oct 2004 14:54:32 -0700 (PDT)
Message-ID: <35fb2e590410011454270f2698@mail.gmail.com>
Date: Fri, 1 Oct 2004 22:54:32 +0100
From: Jon Masters <jonmasters@gmail.com>
To: Jon Masters <jonathan@jonmasters.org>
In-Reply-To: <415D3C2C.7050704@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <35fb2e59040930165327f2dd59@mail.gmail.com>
	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
	<1096602008.14803.16.camel@gaston> <415D3C2C.7050704@jonmasters.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
Reply-To: jonathan@jonmasters.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 01 Oct 2004 12:14:52 +0100, Jon Masters <jonathan@jonmasters.org> wrote:
> Benjamin Herrenschmidt wrote:

> > I'd rather see you guys sync with what I did on ppc64 and use that
> > kind of OF device-tree, we already have all the code for using it
> > and it would make the mecanism compatible with the prep/chrp/pmac
> > kernel...
> 
> Yeah. I'm going to start ripping through your code at the weekend and
> figure out how what you've done - not having a nice shiney ppc64 box
> means I've not yet got an excuse to play with that tree myself. I am
> however hopefull that my next Powerbook will be a G5 :-).

Hmmm...

ppc64 head.S and startup looks quite fun. After jumping through a few
hoops you eventually end up in prom_init and start setting up the OF
device-tree (btw it looks like at least one call to prom_panic doesn't
relocate the string it wants to print to real memory - is this what
the comments are referring to out of sheer interest?). I am assuming
that you always expect to see an Open Firmware on ppc64 and simply use
bi_recs to pass accross additional information from the bootloader,
but I've only had a cursory look on the train on the way home from
work this evening so please be gentle.

I'll give this a go through over the weekend and figure out how to get
this hooked in to the ppc32 tree.

Jon.
