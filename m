Message-ID: <8D7C5F56B409554D9D46AC22195807F30619C0@exchwenz01.smtp.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'John.Fisher@nec.com.au'" <John.Fisher@nec.com.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: cygwin and embedded linux ... a little OT
Date: Fri, 23 Aug 2002 02:46:47 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Our company at the beginning of last year just added Linux to our
development platforms.  There are a lot of free tools to make using two OS's
Linux and Windows very easy.
Firstly there is the question of weather to have a single big and expensive
box for Linux development that all developers log into and used for there
development or does each developer have his own box that he uses.  It does
not have to be as expensive but still needs to be about the same
specifications as his current windows box.
Next is how do you get around the problem of an extra screen, keyboard, and
mouse on the developers desktop.  We started out using a non-freeware
xserver for windows.  This worked well for our evaluation but we quickly
discovered the limitations.  I have been using VNC on Linux and windows for
a while now and it works very well.
One big and expensive server about $9000USD separate machines about $700USD
if you have more that 12 developers then maybe a big server but then you
have need a bigger even more expensive server for 12 developers.

If I was to set up a development environment again it would give each
developer another PC the same specifications as his current windows PC
running Linux (my preference is RedHat 7.3) using Xvnc on boot up and the
windows VNC client can log in to it for the developer can use.  This second
PC does not even have to reside in the developers work area but it is
easier.  The developer needs to have full control of this PC including the
root password.  But this adds to the maintenance of the machines and you
very quickly discover that patches come out often.  Some developers do not
like your chosen Linux distribution.  My experience is that these developers
know how to look after their machine and you don't need to maintain these
PCs.  The way I would set up the workstations would be that the cross
compiler would be mounted form a sopped up workstation somewhere the tftp
server would also sit on one server and each workstation would mount this in
the same place on each workstation.  User accounts would be set up network
wide using NIS or LDAP but the home directory for each developer would
reside on each workstation.  Each developer would have his own network root
partition for his own development and this needs to be kept as close as
possible to what will be stored in flash (this is difficult but possible).
Whoever gets the job of keeping the Linux server and / or workstations up to
date will like using a Linux distribution as it is very easy to apply
patches.  It is not uncommon for me to have 4 or 5 RedHat update agents
running at the same time from different PCs on my one desktop.

This is how I did it but maybe there are better ways I am yet to work out.

Hope this helps a little bit
Regards,
Rod Boyce

 -----Original Message-----
From: 	John Fisher [mailto:John.Fisher@nec.com.au]
Sent:	Wednesday, August 21, 2002 6:15 PM
To:	linuxppc-embedded@lists.linuxppc.org
Subject:	RE: cygwin and embedded linux


> Actually, my personal opinion on that matter is that I'm not very fond
> of using Windows for a Linux kernel development platform. Doing --

So what are the issues: How is cygwin significantly different from Linux
that you would not want to use it?
Are there useful tools that run under Linux but not under cygwin?

The reason I ask is that my organization currently does its software
development under windows using proprietary tools. We have to maintain our
existing products using these tools. We are however contemplating new
development using linux. If we have to dual boot our PCs or have an extra PC
running Linux for each developer, that is going to bring its own set of
nuisances and problems.

Are there others in this situation and how have they chosen to solve it?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
