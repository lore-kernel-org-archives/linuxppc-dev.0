Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1116921302.6395.6.camel@gaston>
References: <1116909286.4992.17.camel@gaston> <1116909351.4992.19.camel@gaston>
	<78325f65fc807da213be423c20ce6dcd@kernel.crashing.org>
	<1116921302.6395.6.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <c7e35bb102646dae463a41a5110d5dfa@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 24 May 2005 10:01:32 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Tzachi Perelstein <tzachi@marvell.com>,
	u-boot-users@lists.sourceforge.net, linuxppc64-dev@ozlabs.org
Subject: Re: Booting the Linux/ppc64 kernel without Open Firmware HOWTO (v3)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yes, we meant names, and yes, there is a limit of 31 characters + 0,

Nah, it's thirty-one chars, not 31.  Sorry for missing this.

> that is 32 bytes (see "3.2.2.1.1 Property names" in 1275. BTW. Do you
> have a useable version of this document ? mine is a totally broken PDF
> made from a crappy .ps :)

Mine is a perfectly working PDF from a perfectly working PS.  I'll send
it to you.

> IBM firmware broke that limit in a couple of places though...

That's what happens if there isn't a testsuite anywhere.

> Yes, I know all that.

Good :-)


Segher
