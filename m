Subject: Re: System ACE MPU interface to CF card
From: Jeff Angielski <jangiels@speakeasy.net>
To: Sharad Gupta <sharad@buckeye.ece.drexel.edu>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <407EDCF7.2020009@buckeye.ece.drexel.edu>
References: <407470ED.3030607@buckeye.ece.drexel.edu>
	 <6058-40021@sneakemail.com> <407ADCFE.8080302@buckeye.ece.drexel.edu>
	 <25757-52278@sneakemail.com>  <407EDCF7.2020009@buckeye.ece.drexel.edu>
Content-Type: text/plain
Message-Id: <1082322389.23738.13.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 18 Apr 2004 17:06:57 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-04-15 at 15:05, Sharad Gupta wrote:
> Your patch helped me a lot in compiling and configuring my kernel. Just
> on a side note, have you been able to talk to compact flash (mount fs on
> it, fsck it ?) through system ace ?
>
> My kernel hangs while doing partition check on the drive. All I ever see is
>
> Partition check:
> xsysacea:
>
> (then nothing happens)

Sounds to me like you do not have your interrupts configured properly
between the SystemACE and the CPU or your xsa_thread is dying
prematurely.

Either way, the kernel is getting no response when it actually tries to
access the CF thru the SystemACE.


Jeff Angielski
The PTR Group


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
