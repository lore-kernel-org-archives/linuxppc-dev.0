Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Jos Beck <jos.beck@euronet.nl>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8xx SCC for sync. HDLC on 2.4 kernel
Date: Tue, 27 Jan 2004 17:20:11 -0200
References: <4016907D.3070901@euronet.nl>
In-Reply-To: <4016907D.3070901@euronet.nl>
MIME-Version: 1.0
Message-Id: <200401271720.11103.scop@digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

On Tuesday 27 January 2004 14:23, Jos Beck wrote:
> I am trying to build a synchronous HDLC driver for the SCC of the
> MPC850/860 under linux kernel 2.4.22
>
> I have got one working on a 2.2.5 kernel and one buggy, async only, for the
> 2.4 kernels.
> What would be the best approach: porting the 2.2.5 driver to the 2.4.x
> kernel or digging into the driver (ehdlc.c by Rodolfo Giometti based on Dan
> Malek's enet.c) to make it work for sync HDLC at high speeds?
>
> Or an alternative?

Well, I have a driver that works both for MPC860 and MPC8260, over linuxppc
2.4.21 and with recent patches of the Generic HDLC Layer. I'm sending it
separately because it's to big for the list.

>
>
> Best regards,
>
> Jos Beck
>
>

--
Ricardo Scop.

--_______----------------------------
 /  ___  \
 \_(@ @)_/
  /  V  \  R SCOP Consult.
 /(     )\ Linux-based communications
/ ^^---^^ \
-------------------------------------
rscop@matrix.com.br
+55 51 999-36-777
Porto Alegre, BRazil


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
