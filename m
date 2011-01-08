Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71E4DB7063
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jan 2011 08:44:04 +1100 (EST)
In-Reply-To: <AANLkTinbdEc2kTVHZp3b31V6sFSqOfquUidb5BZYdgEX@mail.gmail.com>
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>	<4D24B725.2020300@evidence.eu.com>
	<20110105174256.29fd378a@udp111988uds.am.freescale.net>	<4D25BB08.7000001@evidence.eu.com>
	<OFB0350E05.07B070EF-ONC1257810.005CAF17-C1257810.005CAF19@transmode.se>
	<AANLkTinbdEc2kTVHZp3b31V6sFSqOfquUidb5BZYdgEX@mail.gmail.com>
Subject: Re: mpc880 linux-2.6.32 slow running processes
To: Rafael Beims <rbeims@gmail.com>
Message-ID: <OFBA8894F8.FF5AA75D-ONC1257812.00773DA9-C1257812.00776196@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 8 Jan 2011 22:43:57 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: michael@evidence.eu.com, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	scottwood <scottwood@freescale.com>, RFeany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rafael Beims <rbeims@gmail.com> wrote on 2011/01/07 11:00:56:
>
> On Thu, Jan 6, 2011 at 2:52 PM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
>
> >
> > The 8xx tlbil_va should not be needed in recent 2.6 after I fixed t=
he 8xx TLB code
> > to workaround the dcbst bug there instead. See
> > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;=
a=3Dcommitdiff;h=3D0a2ab51ffb8dfdf51402dcfb446629648c96bc78;hp=3D60e071=
fee994ff98c37d03a4a7c5a3f8b1e3b8e5
> >
> > Not sure what release it went into though.
> >
> > =A0Jocke
>
> I saw that the commit you mention did make it in the 2.6.33 version. =
I
> will try to boot it here and see if the problem is also solved in thi=
s
> version.

Once you have tested it and it works, please send a patch to remove the=
 8xx workaround.
Make sure Scott is cc:ed=
