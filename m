To: "Joao Vicente" <joao.vicente@spectel.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAMDISK problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Nov 2003 15:44:48 GMT."
             <DEF39A0710293E489D45B10E06645CBD026718F8@dub-msx1.spectelcorp.com>
Date: Tue, 11 Nov 2003 20:58:39 +0100
Message-Id: <20031111195844.1BA6EC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Joao,

in message <DEF39A0710293E489D45B10E06645CBD026718F8@dub-msx1.spectelcorp.com> you wrote:
>
> CPU:   MPC8260 (HiP3 Rev 01, Mask C.2 6K23A) at 133.333 MHz
> Board: Spectel MC3
> DRAM:  (60x:?COL - 16 MB, 16 MB
-------------^^^

Are you sure your SDRAM initialization is correct?

> RAMDISK: Compressed image found at block 0
> Machine check in kernel mode.
> Caused by (from SRR1=41000): Transfer error ack signal
> Oops: machine check, sig: 7
> NIP: 0000113C XER: 00000000 LR: C0006628 SP: C0FBD4F0 REGS: c0fbd440 TRAP:
> 0200
>    Not tainted
> MSR: 00041000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> TASK = c0fbc000[59392] '' Last syscall: 3
> last math 00000000 last altivec 00000000
> GPR00: 00000000 C0FBD4F0 C0FBC000 C0FBD540 00000000 00000120 00000005 00000005
> GPR08: C0FBD4F8 4E81001B 00000000 00000000 22004042 950A0000 0000003F C0110000
> GPR16: C0150000 C0EE4008 C0EE7008 C0150000 00009032 00FBD530 00000000 C0006074
> GPR24: C0006610 4E80FFFF 00000000 00000001 C0FBD540 00000004 00000009 4E81001B
> Call backtrace:
> 0000007B C0006628 C0006074 000000BB C0006074 C00304D0 C001EA88
> C001EAB4 C000A9D4 C0005EA4 00000000 00000083 Machine check in kernel mode.

Did you bother to decode the cal backtrace?

And are you really, really sure that  your  SDRAM  initialization  is
complete  and  correct? Remember that there is more to do than to set
up the memory controller.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Time is a drug. Too much of it kills you.
                                      - Terry Pratchett, _Small Gods_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
