Message-ID: <3D3ED72C.9020909@mvista.com>
Date: Wed, 24 Jul 2002 09:34:52 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Michael Meriin <Michael@KSWaves.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: idle for m8xx
References: <008e01c232e9$bcea5dc0$3c0fa8c0@amitesting>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael Meriin wrote:

>Hi there,
>
>In all last kernels idle mode for m8xx is implemented as an endless loop.
>Therefore the  idle modes of the m8xx family are not used.
>Implementation of the internal Idle modes of the m8xx family will
>significantly reduce
>the power consumption in the embedded systems.
>Does anybody know how to do this?
>
The ARM kernel does it quite well.  Basically, they have an abstraction
in the idle loop where you can plug in sub-arch/processor specific code
that puts the processor into the idle state.  4xx has idles states that
differ from the rest of the ppc family as well.  It would be nice to
move the power_save routine into the platform code allowing each
sub-arch/processor to define its own.   I have plans on doing exactly
that in the near future, but if you beat me to it....

>
>Best Regards,
>                     Michael Meriin
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
