Message-ID: <E95059F24D57D411B2C200B0D02023B12737B6@shade.CHINOOK.COM>
From: John Crew <jcrew@chinook.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>, clark@esteem.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Loading Hard Hat 2.0
Date: Wed, 15 Aug 2001 17:04:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We installed the Hard Hat 2.0 Professional
version on Red Hat 7.1. There is a minor
install script problem. It checks the version
number in file /etc/redhat-release to decide how
to install. Change 7.1 to 7.0 and then run the
installation script.

I don't know about installing both 1.x and 2.0
on the same machine.

-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Wednesday, August 15, 2001 4:44 PM
To: clark@esteem.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Loading Hard Hat 2.0



On Wed, Aug 15, 2001 at 01:33:56PM -0700, clark@esteem.com wrote:

> 	Has anybody loaded Hard Hat 2.0 Linux Journeyman edition on Red Hat
7.1
> yet? I know its been asked before, but I was wondering if the answer has
> changed from no.

RedHat 7.1 is not a supported target.  See below.

> 	Is there an easy way to install Hard Hat 2.0 without removing my 1.0
> 	install?

Normally, yes.  But, I _think_ the main reason RedHat 7.1 isn't supported
is that the version of RPM shipped by default does NOT support relocation,
so you can't install HHL 2.0 into another subdir and have 1.x and 2.0
co-exist.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
