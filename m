To: =?Windows-1252?Q?Ga=EBl_Martin?= <g.martin@ateme.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200 : dma and IDE 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Mar 2004 14:04:01 +0100."
             <006301c40b57$26dc7960$ad1010ac@pc173>
Date: Tue, 16 Mar 2004 15:04:56 +0100
Message-Id: <20040316140501.864F8C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Gael,

in message <006301c40b57$26dc7960$ad1010ac@pc173> you wrote:
>
> I am using linux on a MPC5200 Lite board. When I activate the DMA on IDE bus
> and try to access to the disk, I have a kernel panic. I have seen in the
> m5xxx.c that DMA is disabled until it will work.

Indeed this is a known problem which cannot be fixed with the current
version of the BestComm microcode.

> Does anybody has a patch for this or should it be done ? If anyone already
> has work on this problem, is it possible to share informations to fix it ?

You will have to wait for the next version of the BestComm code.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I'd rather be led to hell than managed to heaven.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
