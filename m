MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16545.27905.567056.12888@cargo.ozlabs.ibm.com>
Date: Wed, 12 May 2004 10:17:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: Amit Shah <amit.shah@codito.com>
Cc: huailin@xtrj.org, Dan Malek <dan@embeddededge.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
In-Reply-To: <200405112301.30665.amit.shah@codito.com>
References: <20040511172318.88343.qmail@web21412.mail.yahoo.com>
	<200405112301.30665.amit.shah@codito.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Amit Shah writes:

> It's pretty strange then that people would come up with boards based on
> dual-processors of the 7xx family (like the IBM Argan board or the Xcalibur
> boards). Any idea how they use it or what are they intended for?

I think it's the usual hardware designers' attitude that any bugs in
the hardware can be worked around in software.  And they can, it's
just that to address the problems properly is going to take effort,
and no-one has yet had the time, energy and motivation to sit down and
do that (and do it in a way which is sufficiently clean and well
though out to be accepted into the Linux kernel).  Fortunately Apple
never did a 750-based SMP system. :)

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
