Date: Fri, 25 Feb 2000 12:16:24 -0500 (EST)
From: Kevin Kubarych <kjk@lphys.chem.utoronto.ca>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: HFS+ feature request
In-Reply-To: <20000225113608.001404@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10002251211370.5936-100000@lphys.chem.utoronto.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is it just me, or what? Seems to me hfs and hfs+ know about cases--when I
name a file ThisFile, it shows up in the finder with the caps, where does that
information get stored if not on the hfs/hfs+ disk? It's the MacOS that (for
whatever reason) doesn't differentiate between ThisFile and thisfile. Even when
you look at an hfs partition in linux, the cases are there, so it's not some
strange MacOS trick.

Still it seems that case sensitivity will only cause extreme disaster--that is
until everyone is on OS X (which doesn't even support long filenames yet,
whatever).

best, Kevin


On Fri, 25 Feb 2000, Benjamin Herrenschmidt wrote:

:
:On Fri, Feb 25, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
:
:>> 	I think HFS+ would be an excellent OS-coexistance compatibility
:>> filesystem.  It could work on Linux, MacOS 8/9/10, etc.  It supports
:>> multiuser permissions.  Yay.
:>
:>What about special device nodes (oh yes, we have devfs now :-)? Fifos?
:>Sockets?
:
:I think they can be implemented on HFS+ since MacOS X can be rooted on
:it. Note that HFS+ provides an extensible attribute b-tree so any kind of
:specific per-node infos can be added to the filsystem easily.
:
:


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
