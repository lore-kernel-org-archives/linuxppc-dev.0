To: linuxppc-embedded@lists.linuxppc.org
Subject: Sandpoint 8240 or 7400
From: Roland Dreier <roland@topspincom.com>
Date: 26 Jan 2001 17:29:26 -0800
Message-ID: <524rylvl3d.fsf@love-boat.topspincom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, I'm trying to get Linux running on a Motorola Sandpoint.  I have a
8240 and a 7400 available.

So far I've tried running the 8240 kernel from the Montevista CDK 1.2.
The boot seems to hang after printing the "OpenPIC timer frequency is
not set" (I left it waiting for quite a while with no luck).  I get
the same thing on both the 8240 and the 7400.

Then I tried the older kernel from

<ftp://ftp.mvista.com:/pub/Area51/sandpoint-8240>

That kernel seems to freeze up at the same place (it prints more
openpic information, but those print statement just seem to have been
taken out of kernel 2.4 -- I can send them if it would help diagnose
the problem).

Has anyone gotten Linux to boot on a Sandpoint system?  I'm especially
interested in the 7400.

Also, if I wanted to build my own kernel for a Sandpoint system, what
source tree should I use?  And (forgive the naive question) how do I
build a kernel image that I can send to the Sandpoint via the serial
port and start from DINK32?  What are the prospects of being able to
build a PPC kernel from Linus's tree?

Thanks,
Roland


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
