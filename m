Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Gabriel Paubert" <paubert@iram.es>,
	"Jean-Denis Boyer" <jdboyer@mediatrix.com>
Cc: "Troy Benjegerdes" <hozer@drgw.net>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	<linuxppc-embedded@lists.linuxppc.org>,
	"Paul Mackerras" <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
Date: Fri, 10 May 2002 07:39:25 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMEMKDGAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.33.0205101627540.23021-100000@gra-lx1.iram.es>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I thought that this discussion was regarding BogoMips. If so, then you do
not need the RTC, use the 1 second timer. If your concern is returning and
maintaining TOD, then that is RTC.

Right?

> >
> > > I'm afraid that this is a symptom of lost timekeeping
> > > after reading the RTC and that you simply cure the symptom.
> >
> > My platform uses an 8260 processor, and AFAIK there is no RTC.
> The function
> > __USE_RTC() returns 0.
>
> OOPs, sorry for the confusion, by RTC I meant the chip with a battery
> which keeps time across reboots and that we read to initially set the
> system time.
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
