Subject: RE: Cross compiling : problem linking
From: Toni Van Remortel <t.vanremortel@ha.be>
Reply-To: linuxppc-embedded@lists.linuxppc.org
To: Fillod Stephane <stephane.fillod@thomson.net>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <2C1BAF8F8E1DD611862B0002A5D4C3FC01BC068F@renexch3.rennes.thmulti.com>
References: 
	 <2C1BAF8F8E1DD611862B0002A5D4C3FC01BC068F@renexch3.rennes.thmulti.com>
Content-Type: text/plain
Message-Id: <1065169617.14913.7.camel@toni>
Mime-Version: 1.0
Date: Fri, 03 Oct 2003 10:26:57 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Op do 02-10-2003, om 18:34 schreef Fillod Stephane:
> Note to the list: sorry for the RFC2822
>
> > Do you know the replacement for iopl to work on PowerPC?
>
> There's no such crap on PowerPC. No separate IO bus either.

Darn. I've once seen an example somewhere on the net on controlling an
output pin on the EP405 (from kernel space), but I can't remember where
:(

> > Final goal is a kernel module, but now I'm writing a test program in
> > user space (standalone, dynamic compiled).

Now I know that the difference between user and kernel space is so
different, I'll only try to go for the final result: a kernel module.

> Okay, let's use ESP for once :)

What is ESP?

> Toni, I don't know what's your "base" address, but it is really odd
> (well, both ways :) on a PowerPC system. You should borrow some help
> from your D-science lab, or have something like a PPC Linux training.

I'm afraid I should go for the last one. The D-science lab is actually
specialized in usability and product design testing. There is only one
technological project running, namely mine, which is about embedded
Linux. I started working on this project when I was just about half a
year graduated as industrial engineer. So my Linux knowledge was limited
to desktop use and installation.
You'll probably think I'm asking things that every embedded Linux
developer knows, but I'm not one, I'm just trying to understand
everything. Aside that, my platform knowledge is zero. That's why I come
up with code for x86 to run on PPC ;)

PS: that "base" address was fetched from ibm405gp.h (the ECB base
address).
--
                           Toni Van Remortel
              Wetenschappelijk Medewerker - D-science lab
  Real time Linux for embedded systems: http://linemb.d-sciencelab.com
              Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
                      E-mail: t.vanremortel@ha.be


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
