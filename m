To: ramp@oddjob.uchicago.edu
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Updated Mozilla M13 Release Build Available
In-reply-to: Your message of "Fri, 28 Jan 2000 09:15:56 CST."
             <Pine.LNX.4.10.10001280907150.2865-100000@xpol.uchicago.edu>
References: <Pine.LNX.4.10.10001280907150.2865-100000@xpol.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Jan 2000 09:38:55 -0600
From: Kevin Puetz <puetzk@iastate.edu>
Message-Id: <E12EDU8-0002IT-00@puetz.penguinpowered.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


****

Before I answer thes, are there any people with positive reports? I need to
hear from you if it installed perfectly as well as if you had problems. Please
be sure you include me directly in the replies to this message. I'm cc'ing the
list in case anyone else is interested in simplebrowser.

****

ramp@oddjob.uchicago.edu said:
> Well I'm still having problems. I do have libstdc++-2.10.0 and it
> still  seems to not do anything. Maybe part of this has something to
> do with ldconfig. What is a typical /etc/ld.so.conf look like. Mine is

I'm afraid you may just not have enough RAM for mozilla. While a lot faster
and more stable than communicator was, it's still a big browser, with quite an
appetite for RAM (and/or swap). You chould give simplebrowser a try -

 cd ..../package
./run-mozilla.sh ./simplebrowser

This is the raptor (mozilla) layout engine, but with much of the browser
eye-candy stripped away. It runs in about 8 megs here to mozilla's 25+(numbers
are somewhat misleading because of shared libs, segments shared with the
Xserver, etc, but still comparable), so it's probably more likely to work.
Good luck.

> $ cat /etc/ld.so.conf /usr/X11R6/lib

No, /usr/lib (and /lib, and maybe others) were compiled into ld.so. the config
file serves to add others after the fact.

> However I noticed that there are libraries in /usr/lib. Do those
> needed need to be added as well?

> Sorry for these newbie questions, Ramprasad
That's fine, they have too be asked by everyone at least once :-)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
