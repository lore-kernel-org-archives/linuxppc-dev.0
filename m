Message-ID: <3E8A4EE1.8090205@mvista.com>
Date: Tue, 01 Apr 2003 20:45:53 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux support for MPC859T processor
References: <3E8A4B70.7090607@tait.co.nz>
In-Reply-To: <3E8A4B70.7090607@tait.co.nz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On userspace basis.. the 860 and the 859 are fully compatable.. The need for
859T changes may be in the kernel.  So anyone who sells/supports an 860 based
system can support your needs for application level.  (That includes MontaVista.)

The linux kernel of course is a different level of complexity.

--Mark

Dmytro Bablinyuk wrote:
>
> We are trying to find a linux supplier who supports Motorola MPC859T
> processor (actually it will be processor from Motorola but our custom
> board).
> We have contacted MontaVista and we discovered that the nearest
> processor they support is MPC860.
> Also we discovered that:
>
> An MPC860 based board might be suitable for initial S/W development
> purposes as the chip is very similar to the MPC859T we intend to use.
> There are 7 variants of the '860 with different cache sizes and serial
> communications capabilities.
> The main differences between the '860 and the '859T that I am aware of are:
>
> 1.    The '860 runs at approximately half the speed of the '859T.
> 2.    The clocking generator for the 860 would require a different
> configuration to the the '859 as a consequence of above.
> 3.    The '860 has an internal RTC function whereas the '859T does not.
> 4.    The '859T has a dedicated 10/100Mbps ethernet MAC whereas the '860
> has to use the serial communication controllers for ethernet operations.
> The available ethernet speeds depend on the particular variant of the '860.
> Note some of the '860 variants include a dedicated 10/100Mbps ethernet MAC.
> 5.     The '859T core operates off a lower voltage (1.8V) for power
> saving whereas the '860 core runs off a 3.3V supply.
> Consequently the '860 draws approximately 2x the power of the '859T.
>
> Apart from the differing core voltages the '860 and '859T appear to be
> pin compatible
>
> * Could somebody please give me an advice on how much S/W work might be
> involved in the future to port linux from '860 to '859T based on 1-5
> (see above)
>
> * Can you suggest (based on above) any of 7 variants of the '860
>
> Thank you
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
