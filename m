Message-ID: <3BA3D432.350C697@mvista.com>
Date: Sat, 15 Sep 2001 18:20:34 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Michael Habermann <MHabermann@gmx.de>
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU and BDI2000
References: <Your message of "Fri, 14 Sep 2001 17:58:29 +0800." <5.1.0.14.0.20010914174808.026db880@pop.gmx.de> <5.1.0.14.0.20010915223300.02bef9f0@pop.gmx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael Habermann wrote:

> How do I get the swapper_pg_dir? Is it the constant address from System.map?

Ooops...You shouldn't have seen any version of the software that makes
any
reference to swapper_pg_dir.....

The configuration file you attached looks fine for the recent 2.4
kernels.
If you want to backtrace into the currently running application (useful
for system call parameters), ensure you enable the 'CONFIG_BDI_SWITCH'
option.  I left it disabled by default because it adds three
instructions
to the context switch overhead.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
