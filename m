Subject: Re: mpc8260 and flash
From: Gagneraud Christian <cgagneraud@anfora.fr>
To: ppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1033718159.13274.1410.camel@christian.anfora>
References: <1033718159.13274.1410.camel@christian.anfora>
Content-Type: text/plain; charset=ISO-8859-15
Date: 04 Oct 2002 12:02:15 +0200
Message-Id: <1033725770.12154.1434.camel@christian.anfora>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Le ven 04/10/2002 à 09:55, Gagneraud Christian a écrit :
>
> Hi all,
>
> Still now i use an mpc8260ads baord with Linux 2.4.4 from denx.de,
> the 8260ADS board have 8Mbytes/32bits of flash organize as 4 chip 8bits
> wise each. (on a flash SIMM: 4*(sharp 28f016) = 4*[2M*8bits] = 8MBytes
> in 1 bank)
>
> But now i have to make my own board.
> I want to have 32MBytes/64bits of flash organize as 4 chip 16bits wise
> each. ( 4*[Fujitsu MBM29LV650] = 4*[4M*16bits] = 32Mbytes, this chip is
> supported by linux-mtd).
>
>
> My first question is about Chip Selects and Write Enable lines:
> - On ADS, the 4 flash chips CS signals are connected to MPC8260 CS0
> (GPCM machine is use), and the 4 flash chips WE lines are conected to
> the 4 bottom MPC8260 byte-WriteEnable signals.
> - On my design i want to use 16 bits flash but they have only one WE
> signal per device, is it possible to connect the 4 word-WriteEnable
> lines to the MPC8260 byte-WriteEnable?
>
> My second question (maybe related to the first) is about the MPC8260
> Burst addresses lines (baddr[27..31])
> - On ADS baddr[27..29] are connected to the A[2..0] of the flash chips.
> Why are the MPC8260 baddr[27..29] connected to the flash ans why not the
> MPC8260 A[27..29]

Forget this question, i found the information that i need:
=>[...]Thes pins are used in external master configuration[..]
So For my design, i don't care about baddr[], so i have to connect MPC
A[27..29] to flash A[2..0]




>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
