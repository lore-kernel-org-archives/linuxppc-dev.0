Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Bill Fink" <billfink@mindspring.com>,
	"LinuxPPC Developers" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: Debugging Network Performance
Date: Wed, 5 Jun 2002 06:16:18 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMECIDIAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020605011832.63bf4ff5.billfink@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>     "It would be interesting to see where the cpu is being used. Could you
>     boot with profile=2 and use readprofile to find the worst cpu hogs
>     during a run?"

Where can I find documentation on the profile=## option? Are there also
tools that will help to interpret the logs?

> The problem with the poor SUNGEM performance turned out to be lots of
> extraneous unnecessary interrupts, so you might want to check out the
> eth0 interrupts in /proc/interrupts, comparing the two cases.

I will check the interrupts. There are several errata regarding the FCC
interface. I know that the code considered these cases but I need to make
sure that it did not get removed mistakenly.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
