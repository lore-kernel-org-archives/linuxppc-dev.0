Message-ID: <002201c329c0$36b5a740$940ca8c0@analogue.domain>
From: "Frank Robbins" <Frank.Robbins@Analogue-Micro.com>
To: <Flavio.Pereira@za.flextronics.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <742AC4678EF8464697DDDFE3B40F6ECD07E2CE@srv-mailrnd.azisa.co.za>
Subject: Re: System crash in kernel_thread 
Date: Tue, 3 Jun 2003 12:06:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A few questions you need to ask yourself

1. Is this your own Hardware ?
2. How did you arrive at your SDRAM UPM Table
3. Are your connections identical to the one used
4.  Do you have buffers in the connection between the SDRAM and the MPC*xx.
This is normally unwise..and will mean more UPM modifications.
5. What have you set the refresh to on the SDRAM? Is it correct?
6. As soon as the MMU is enabled it will blow any missconfigured SDRAM to
bits.(I will run erratic .. not blow the chip up).
7. Bursting needs to enabled as everything will run at a snails pace with
the MP8xx.

Best of luck I have been here many times

Frank Robbins


----- Original Message -----
From: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Tuesday, June 03, 2003 11:12 AM
Subject: RE: System crash in kernel_thread


>
> Hi Wolfgang
>
> >One pretty common reason is that your SDRAM initialization sequence
> >may be buggy and/or incomplete, and you experience memory errors. Re-
> >member that more is required than just adapting the UPM tables.
>
> Hmmm, that is interesting. Does Linux require that burst mode access be
> enabled, right now I have the BI bit set in the OR register. I also
> ported SD-RAM tests into u-boot, the tests the entire memory range with
> pattern and address and this looks good. I've obviously had to change
> the UPM config, OR, BR registers, MCR register, MAMR register. I can't
> think of anything else that would require some attention. Could this in
> any way be related to cache?
>
>
> Thanks
> Flavio Pereira
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
