Message-ID: <20030707044600.37837.qmail@web9707.mail.yahoo.com>
Date: Sun, 6 Jul 2003 21:46:00 -0700 (PDT)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: MPC8260 ATM channel allocation.
To: Sanjay Kumar <skumar@giga-stream.de>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <FKEJLMJFECLAHOKCGJFPIEAFCBAA.skumar@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 MPC8260 supports 255 internal chans and 64k external
for each FCC. (There is no sharing among resources).
Thats the same for the BDs.
 ATM switching has not been implemented for the 8260
(as far as I know). Alex has implemented one for 860.
You could import that (switcher.c). So you will have
to open 1 bidirectional channel for each FCC.

               Hope this helps
                   Dimitris.

--- Sanjay Kumar <skumar@giga-stream.de> wrote:
>
> Dear all,
>
> I am using MPC8260 for ATM cell switching between
> FCC1 and FCC2.I have two
> UTOPIA interface connected,one each to FCC1 and
> FCC2.FCC1 is connected 16
> PHY devices and FCC2 is connected 2 PHY devices.I
> have following
> questions.
> 1.MPC8260 supports 255 internal channels and upto
> 64k using external
> memory. Does this number of channels(upto 64k) are
> for both FCC1 and FCC2
> ? If yes how these channels can be distributed
> between FCC1 and FCC2. For
> transfering ATM cells from FCC1 to FCC2 and
> vice-versa I have to open an
> input channel on FCC1 and an output channel on
> FCC2.Does this input and
> output channel number should be unique?
>
> 2. MPC8260 limits 256k for RX BDs(buffer
> descriptors) and 256k for TX BDs.
> Does this limitation is per FCCs ? I mean can I
> allocate 256k RX BDs and
> 256K TX BDs for FCC1 and then
> 256k RX BDs and 256K TX BDs for FCC2?
>
> Any idea....
>
> regards,
> sanjay
>
>
>
==============================================================
>  Sanjay Kumar
> skumar@giga-stream.de
>  GIGA-STREAM UMTS Technologies GmbH  Tel: +49
> (07243) 94976-119
>  Im Ermlisgrund 8                    Fax: +49
> (07243) 94976-100
>  76337 Waldbronn
>
>
==============================================================
>
>


=====
------------------------------------------------------------
-Dhmhtrios Meidanis
-Degree in Mathematics, University of the Aegean.
-Master in Computer Architecture and Digital
 Systems, University of Crete.
 Greece.
------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
