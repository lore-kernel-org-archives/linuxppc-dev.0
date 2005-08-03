Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 2CDF967E37
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 16:40:19 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so90801wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 02 Aug 2005 23:40:18 -0700 (PDT)
Message-ID: <9b7ca65705080223401a9ce913@mail.gmail.com>
Date: Wed, 3 Aug 2005 15:40:18 +0900
From: Daniel Ann <ktdann@gmail.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <61C27372-4ADB-4E3A-8E20-9E811EE61B99@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9b7ca6570508022240715ae9cb@mail.gmail.com>
	<61C27372-4ADB-4E3A-8E20-9E811EE61B99@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8245 reboot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Absolutely not. Very much like sandpoint except, we dont use SIO at all.
FYI, most of sandpoint code from the kernel is function the board very
well at the moment. Only big issue lies with REBOOT at this stage:(


On 8/3/05, Kumar Gala <kumar.gala@freescale.com> wrote:
> Do you have a VIA chipset on your system?  If not what sandpoint is
> doing is not going to help you much.
>=20
> - kumar
>=20
> On Aug 3, 2005, at 12:40 AM, Daniel Ann wrote:
>=20
> > Hey folks,
> >
> > I have a problem with rebooting my box(its pretty much based on
> > sandpoint).
> > Looking at sandpoint_restart() function, I have no idea what it's
> > doing. Can somebody please help me out where I should be looking ?
> > Would this be pure software problem? or just might be hardware problem
> > ?
> >
> > Always thought rebooting was piece of cake, but.. guess not :P
> > --
> > Daniel
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
>=20
>=20


--=20
Daniel
