Message-ID: <6B546A602AD2D211BFF00008C7A4288905843FE0@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'David Ashley '" <dash@xdr.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux 2.4.17 bug, mmap of /dev/mem
Date: Thu, 14 Feb 2002 10:22:22 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi David,

I tested your application on my board (Embedded Planet CLLF (mpc860), Linux
2.4.2) and made a script that executes it as fast as possible.
I let it run for 10 minutes on several telnet sessions simultaneously but I
do not see anything strange... The memory I write to is NVRAM.

Frederic

-----Original Message-----
From: David Ashley
To: linuxppc-embedded@lists.linuxppc.org
Sent: 2/12/02 1:36 AM
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem


I found out more about the problem. If I mmap 2 regions that are
distinct,
even though they map to the same physical address in non-cacheable
memory,
if I only use one for reading and the other for writing, there is no
corruption of linux and the system works. The problem happens when I
both
read and write to the same mmap'd area.

Easy enough workaround. Now maybe some kernel expert can figure it
out???????

Later--
Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
