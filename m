Date: Tue, 08 Apr 2003 14:36:07 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: I2C RTC causes boot delay...
In-reply-to: <3E92BE98.4090907@imc-berlin.de>
To: Steven Scholz <steven.scholz@imc-berlin.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLCENDFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > You may also want to add an "I2C reset sequence" in your firmware/kernel
> > if your I2C clock gets stuck and don't respond(can happen if reset/power down while
> > reading the RTC). Look in u-boot for details.
>
> Yeah. I know. I should put into PPCBoot/U-Boot.
> But in the docs it says it's only for SOFT_I2C aka bitbang!
> So
> a) can I toggle the pins using GPIO and still use HARD_I2C? or
> b) can I use SOFT_I2C in PPCBoot and CPM I2C (8xx-algo) under linux?

You can do alt. b(I do, NP). Maybe it's possible to make HW I2C do
the same, but I havn't checked.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
