Message-Id: <200010170556.HAA06892@piglet.grunz.lu>
Date: Tue, 17 Oct 2000 07:56:09 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: dual head r128
To: paulus@linuxcare.com.au
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <14827.39263.212734.807452@argo.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  17 Oct, this message from Paul Mackerras echoed through cyberspace:
> I think iobase should be a constant, and we should set up our virt ->
> phys mapping to do anything fancy that we might need.

The discussion about IO seems to always concentrate on kernel access of
IO space. How would you address user space access? Does the syscall
that's been discussed address this to an acceptable degree?

>> > Unfortunately, there's no simple way to allow two busses to have the
>> > legacy IOs. That means on UniN machines that they'll be available either
>> > on the AGP bus, or the external PCI bus, but not both.
>>
>> Indeed, this is too awkward (is tere no way to redirect only the VGA
>> part of the legacy I/O space ? That's what the PCI-PCI bridges do, but
>> I've not yet used a single machine with AGP so I'm ignorant).
>
> Could someone fill me in on why we need legacy I/O to the AGP bus?

Legacy VGA?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
