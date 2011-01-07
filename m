Return-Path: <rbeims@gmail.com>
Received: from mail-fx0-f66.google.com (mail-fx0-f66.google.com
	[209.85.161.66]) by ozlabs.org (Postfix) with ESMTP id A6784B7151
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jan 2011 21:00:59 +1100 (EST)
Received: by fxm14 with SMTP id 14so5085391fxm.9
	for <linuxppc-dev@ozlabs.org>; Fri, 07 Jan 2011 02:00:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OFB0350E05.07B070EF-ONC1257810.005CAF17-C1257810.005CAF19@transmode.se>
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
	<4D24B725.2020300@evidence.eu.com>
	<20110105174256.29fd378a@udp111988uds.am.freescale.net>
	<4D25BB08.7000001@evidence.eu.com>
	<OFB0350E05.07B070EF-ONC1257810.005CAF17-C1257810.005CAF19@transmode.se>
Date: Fri, 7 Jan 2011 08:00:56 -0200
Message-ID: <AANLkTinbdEc2kTVHZp3b31V6sFSqOfquUidb5BZYdgEX@mail.gmail.com>
Subject: Re: mpc880 linux-2.6.32 slow running processes
From: Rafael Beims <rbeims@gmail.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Jan 6, 2011 at 2:52 PM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:

>
> The 8xx tlbil_va should not be needed in recent 2.6 after I fixed the 8xx=
 TLB code
> to workaround the dcbst bug there instead. See
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;h=3D0a2ab51ffb8dfdf51402dcfb446629648c96bc78;hp=3D60e071fee994ff98=
c37d03a4a7c5a3f8b1e3b8e5
>
> Not sure what release it went into though.
>
> =A0Jocke

I saw that the commit you mention did make it in the 2.6.33 version. I
will try to boot it here and see if the problem is also solved in this
version.

Rafael
