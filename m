Return-Path: <vijay.t.nikam@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 8D455DDFAA
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 16:41:13 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 27so3164699wfd.15
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Mar 2009 22:41:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090311142708.olkbrtn5hws0cg8w@www.bish.net>
References: <20090311115234.7hmj4jj79csgk4wo@www.bish.net>
	<A0ED6D80-FD02-4BED-B50B-7F3028E47888@kernel.crashing.org>
	<20090311120300.atgtikpneo0gos0w@www.bish.net>
	<20090311165320.GB11120@ld0162-tx32.am.freescale.net>
	<20090311142708.olkbrtn5hws0cg8w@www.bish.net>
Date: Mon, 16 Mar 2009 11:11:11 +0530
Message-ID: <f234e2140903152241i7a8b4c39jd4b4f5935bffed3e@mail.gmail.com>
Subject: Re: Freescale MPC8313ERDB-RevA and newer BSP/kernel
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: Mark Bishop <mark@bish.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Mark,

Could you please let me know how you booted the latest Linux kernel on
MPC8313ERDB board ? ? ? As I tried but was not successful. It hangs or
does nothing and waits at network configuration, mean to determine IP
address (as I have used dhcp).

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam


On 3/11/09, Mark Bishop <mark@bish.net> wrote:
>
> Quoting Scott Wood <scottwood@freescale.com>:
>
>
> > On Wed, Mar 11, 2009 at 12:03:00PM -0400, Mark Bishop wrote:
> >
> > > Yes I have actually. =A0I have booted a 2.6.28.6. =A0Same problem.
> > >
> >
> > I've booted many recent kernels on revA 8313ERDB; networking works fine=
.
> > I'll try 2.6.28.6 specifically, though u-boot is acting up at the momen=
t
> > so I have to address that first. :-(
> >
> > Are you using the stock config and device tree from 2.6.28.6, or have y=
ou
> > made any changes?
> >
> >
> > > Also, is it me but at some point from 2.6.23 to 2.6.28 did they
> > > started using hex numbers in the .dts file for "interrupts =3D " with=
out
> > > the 0x preamble?
> > >
> >
> > Yes. =A0dts version 0 had hex by default (with OF-like radix prefixes),=
 and version 1 (indicated by
> > /dts-v1/; at the top of the file) has decimal by default (with C-like
> > radix prefixes).
> >
> >
> > > I've been looking at 2.6.20, 2.6.23, and 2.6.28 .dts files for this
> > > board and .28 looked way different in the interrupt section for the
> > > eTSEC.
> > >
> > > Quoting Kumar Gala <galak@kernel.crashing.org>:
> > >
> >
> > Please don't top-post.
> >
> >
> > > >>The boards we received didn't have SPI compiled into the kernel and
> > > >>when we went to go re-compile the kernel using the 20081222 and
> > > >>20080711 BSPs. =A0I realize that the interrupts were reversed for
> > > >>eTEC1 and eTEC2 and I've made the changes in the .dtb file and I no
> > > >>longer hang when I ping, etc. =A0 But I still can't get the board o=
n
> > > >>the network. =A0I've verified it isn't the network settings.
> > >
> >
> > You're sure you're not trying to talk to the switch (which will claim
> > link-up regardless of what's plugged into it)? =A0The non-switch ethern=
et
> > port is eTSEC2.
> >
> > What *does* it do when you ping, if neither hang nor work?
> >
> > -Scott
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> >
> >
>
> After remapping the IRQs, it is working now.
>
> Any idea on what I need to do to get SPI working? =A0I've compiled it int=
o the kernel but don't see anything in /proc/bus
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
