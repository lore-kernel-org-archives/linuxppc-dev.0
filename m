Message-ID: <3A7AD949.6548B3F1@mvista.com>
Date: Fri, 02 Feb 2001 10:59:05 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Rolf Liu <rolfl@sc.mcel.mot.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: power management on linux ppc
References: <031901c08b3a$40a3bb10$bf0102c8@sc.mcel.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Rolf Liu wrote:

> does linux-ppc support power management to reduce the power consumption ?
> Does there exist such driver for mpc8xx ?

The MPC8xx processors have dynamic power management built into the
silicon.  If devices are idle or not enabled, they draw minimal or
no power.  The sleep/nap/doze power functions could be enabled to
slow the processor core, and external clocks driving memory or
other devices, but this would be custom to the external devices
in a system.

	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
