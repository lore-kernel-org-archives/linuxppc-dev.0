Date: Tue, 6 Jul 2004 08:28:55 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Jean-Christophe Dubois <jdubois@mc.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: proposed patch for cross compiling from Solaris 2.8
In-Reply-To: <1089105643.31278.228.camel@fr-jdubois1.ad.mc.com>
Message-ID: <Pine.LNX.4.44.0407060823120.2040-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 6 Jul 2004, Jean-Christophe Dubois wrote:
> Hi,
>
> I got into several issues while trying to cross-compile a Linux 2.6 PPC
> kernel from a Solaris 2.8 host (beside getting a valid cross compilation
> chain). Mainly some programs compiled on the host are not planned to be
> compiled on anything but Linux (The host has to run Linux).

All of the things you've changed look wrong to me.

Most of your changes are taking out <stdint.h>, which is not correct.
This header should be on any system, it is part of the C standard. Even
the getopt changes shouldn't be required, you should be using the
version of getopt that came with your package.

Are you sure that you've specified -nostdinc -nostdlib and given the
proper list of locations for the cross-compile system includes when
compiling?

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
