Date: Thu, 15 Apr 1999 09:58:20 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Hans-Bernhard Broeker <broeker@physik.rwth-aachen.de>
cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Patch] linuxppc gnuplot segfaults in save
In-Reply-To: <Pine.OSF.3.94.990415085424.20465D-100000@acaxp6>
Message-ID: <Pine.LNX.4.10.9904150957440.4519-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 15 Apr 1999, Hans-Bernhard Broeker wrote:
> If ElectricFence or Checker-gcc are available for LinuxPPC, it might be a
> good idea to use one of those to see where the problem comes from. 

| callisto$ dpkg -s electric-fence
| Package: electric-fence
| Status: install ok installed
| Priority: standard
| Section: devel
| Installed-Size: 51
| Maintainer: Siggy Brentrup <bsb@debian.org>
| Version: 2.0.5-4.1
| Description: A malloc(3) debugger
|  Use virtual memory hardware to detect illegal memory accesses.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
