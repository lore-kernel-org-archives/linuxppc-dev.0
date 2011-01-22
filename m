Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4CB5BB70ED
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Jan 2011 12:51:06 +1100 (EST)
Subject: Re: BootX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTi=CVNC-UjdCyByyey_VnPHGtujuH01tquSQyqRm@mail.gmail.com>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<1295644908.2148.309.camel@pasglop>
	<AANLkTi=CVNC-UjdCyByyey_VnPHGtujuH01tquSQyqRm@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 22 Jan 2011 12:50:56 +1100
Message-ID: <1295661056.2148.334.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-01-21 at 19:48 -0600, kevin diggs wrote:
> Hi,
> 
> This would require quik, right? I went to penguinppc.org and tried to
> get the latest BootX and quik but the links are dead. Do you know
> where the latest versions are?

That link still works:

Oops... typing FAIL :-)

I meant:

http://penguinppc.org/bootloaders/quik/

However, it's possible that distros like debian have done more changes to it.

Another option is to netboot a zImage directly, which works if it's not
too big.

Cheers,
Ben.

> kevin
> 
> On Fri, Jan 21, 2011 at 3:21 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Fri, 2011-01-21 at 13:26 -0600, kevin diggs wrote:
> >> Hi,
> >>
> >> Anyone familiar with BootX? Could my problems with the 8600 be related
> >> to some interaction with BootX?
> >
> > It's possible. Have you tried using OF booting instead ? The 8600 should
> > be cable to boot off SCSI or netboot COFF images.
> >
> > Cheers,
> > Ben.
> >
> >
