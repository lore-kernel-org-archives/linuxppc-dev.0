Message-ID: <38FFA264.4D436FB@ccrl.mot.com>
Date: Thu, 20 Apr 2000 19:35:48 -0500
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Jason Wohlgemuth <jsw-embedded@mindspring.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: QSPAN PCI wierdness
References: <NCBBKJKKGDLPHKDPAFFMOECDCEAA.jsw-embedded@mindspring.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


That would be it. Thank you. I gues I've failed the #1 rule - always
check the archives first. In fact come to think of it, I saw your
posting the first time and I think I saved it away in a safe place so that
I could come back to it later. Duh!

Steve

Jason Wohlgemuth wrote:

>
> It seems that in the inline-assembly in qspan_pci.c the compiler doesn't
> recognize that the first argument to the assembly may be modified.  This
> resulted in a register getting trashed where it shouldn't have.  To fix the
> problem I modified the in-line assembly to tell the compiler that this
> register has been changed.
>
> 86c86
> <               : "=r"(x) : "r"(addr) : "%0")
> ---
> >               : "=r"(x) : "r"(addr))
>
> Jason <jwohlgem@mindspring.com>

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
