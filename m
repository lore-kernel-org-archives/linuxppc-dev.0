Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Jaap-Jan Boor <jjboor@aimsys.nl>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: early return set_multicast
Date: Wed, 3 Mar 2004 16:01:28 -0300
References: <Pine.LNX.4.44.0403031706440.10579-100000@linpc003.aimsys.nl>
In-Reply-To: <Pine.LNX.4.44.0403031706440.10579-100000@linpc003.aimsys.nl>
MIME-Version: 1.0
Message-Id: <200403031601.28119.scop@digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

On Wednesday 03 March 2004 13:09, Jaap-Jan Boor wrote:
> Hi,
>
> does somebody know why there is an early return;
> statement in the set_multicast_list() function
> of 8260_io/fcc_enet.c (or cpm2_io/fcc_enet.c)?
>

[snip]

Well, probably the code after the early return is broken ;). Which kernel
version is that? There used to be at least one bug in the for statement (lack
of a dmi=dmi->next statement inside it, AFAIR).

>
> thanks,
>
> Jaap-Jan

Your welcome.

--
Ricardo Scop.

  _________
 /  _____  \
 \_/(@ @)\_/
   /  V  \   R SCOP Consult.
  /(     )\  Linux-based communications
---^^---^^------------------------------
rscop@matrix.com.br
+55 51 999-36-777
Porto Alegre, RS - BRazil


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
