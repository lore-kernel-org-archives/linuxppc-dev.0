Message-ID: <398895AC.C6576613@execpc.com>
Date: Wed, 02 Aug 2000 16:42:04 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: future of drivers/macintosh (was Re: CONFIG_PPC != Mac)
References: <Pine.LNX.4.10.10008021351010.427-100000@cassiopeia.home> <20000802211535.26758@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> I don't think there's real need anymore for an adb directory. The only
> file in it would be adb.c. The mouse and kbd drivers are moving to input,
> the controller drivers (Cuda,PMU) do not only ADB but all sort of other
> machine admin tasks (like power control, I2C, ...) and so are needed even
> whithout ADB support as part of "PowerMac" support. Cuda can be shared
> with m68k, maybe PMU too, so drivers/macintosh is not a so bad place for it.

would it be a prudent move to relocate most of drivers/macintosh to
drivers/char, with the exception of mediabay.c to drivers/block/mac-mediabay.c?

Something that fits the current layout scheme in a bi-partisan way.

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
