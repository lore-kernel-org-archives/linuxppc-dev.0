Date: Fri, 10 May 2002 16:29:21 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: Troy Benjegerdes <hozer@drgw.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-embedded@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
Subject: RE: Bogomips and loops_per_jiffy
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFFA00A@mail.mediatrix.com>
Message-ID: <Pine.LNX.4.33.0205101627540.23021-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 10 May 2002, Jean-Denis Boyer wrote:

>
> Grabiel,
>
> > I'm afraid that this is a symptom of lost timekeeping
> > after reading the RTC and that you simply cure the symptom.
>
> My platform uses an 8260 processor, and AFAIK there is no RTC. The function
> __USE_RTC() returns 0.

OOPs, sorry for the confusion, by RTC I meant the chip with a battery
which keeps time across reboots and that we read to initially set the
system time.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
