Message-ID: <20040511205120.94854.qmail@web21405.mail.yahoo.com>
Date: Tue, 11 May 2004 13:51:20 -0700 (PDT)
From: Huailin Chen <chen_huailin@yahoo.com>
Reply-To: huailin@xtrj.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
To: Amit Shah <amit.shah@codito.com>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200405112301.30665.amit.shah@codito.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When talking about Multi-Processor arch, we have to
consider the chipset support, especailly for the bus
protocol part.

For the particular PowerPC G3 vs. G4 issue, the thing
is: If you have a G4 with MPX support, it would be not
wise if have a chipset with ONLy 60x support. I mean,
going for SMP is to achieve high performance. However,
your goal will not be achieved if you don't have a
good system bus throughput, which usually is the real
bottleneck for an appliance.

Also, I even don't think GT64260 have the Door Bell
stuff with which one cpu can send external interrupts
to another.

For bus protocol itself, there are some signal/pins
different in MPX than 60x. Most of them is from data
streaming and so on, in order to remove dead circles
and so on.

For more detail, try to some data sheet about your
chipset.

Huailin,

--- Amit Shah <amit.shah@codito.com> wrote:
>
> It's pretty strange then that people would come up with boards based
> on dual-processors of the 7xx family (like the IBM Argan board or the
> Xcalibur boards). Any idea how they use it or what are they intended
> for?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
