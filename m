Message-ID: <4F7C25239E293B4A80E2533CF88DB61B0109F36F@tarexch01.tamest.terayon.com>
From: "Baevsky, Igal" <igal.baevsky@terayon.com>
To: "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
	Tim Seufert <tas@mindspring.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"Baevsky, Igal" <igal.baevsky@terayon.com>
Subject: RE: pmac_halt() bug
Date: Tue, 11 Nov 2003 14:03:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When in MacOS I can just unplug the power cable and put it back and the
system will power on. On linux it's not working - after power cable is back,
the system is not powering on.
After playing with /etc/init.d/halt script I managed to bring system to the
state where all processes are stoped and all FS are unmounted but the system
is still up.
As I understand, I need some module or tool to write something to the MAC
bios or eeprom whatever, during linux startup. Can somebody tell me what can
I use ?
Thanks,
Igal.

-----Original Message-----
From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
Sent: Tue, November 11, 2003 10:25
Subject: Re: pmac_halt() bug

> That's precisely it. Some (all?) pmacs with server mode don't
> automatically turn on after an intentional shutdown, only after power
> is lost. So the idea is to have the UPS signal the computer to halt,
> and then have the UPS cut power once it's safe. Later the UPS switches
> power back on and the computer will automatically boot.

Ok, 2 things:

- How does the UPS knows it's "safe" ?
- And right, I need to disable server mode to be able to shut down :) So
I indeed to that on those machines

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
