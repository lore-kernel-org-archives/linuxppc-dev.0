Message-Id: <v04003a02b672a78bae3c@[24.70.162.12]>
In-Reply-To: <3A4CD374.40754688@mvista.com>
References: <3A4CC527.BF9431A7@mailbag.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 29 Dec 2000 14:52:59 -0600
To: Dan Malek <dan@mvista.com>, Tim Montgomery <tjmontgo@mailbag.com>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: 64 bit memory access
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:09 PM -0600 12/29/2000, Dan Malek wrote:
>Tim Montgomery wrote:
[...]
>> Any suggestions/insight would be appreciated.
>
>Using 64-bit only I/O, and FP registers on a 32-bit processor is
>an interesting hardware/software hack, but not a very good system
>design.
>
>I guess we could write some kernel 64-bit I/O functions that use
>an FP register.  This would require disabling interrupts, enabling
>the FPU in the kernel, saving a register, doing the I/O, restoring the
>register, disabling the FPU, and enabling interrupts.  Not very efficient
>when a proper 60x bus implementation that allowed sizing would have
>been really fast.........

I'm almost tempted to say that the classic BSD-ish meme might apply here:

Q: How do I work around XYZ hardware bogosity?
A: Buy better hardware.

But of course, back in the world of linux, the "We Luv Everybody" OS, hope
still lays in the form of unmergable patchsets, but I would be dissapointed
if IO functions like these were to their way into any mainstream kernel.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
