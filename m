Message-Id: <m11dr0J-0000WVC@tri-yann.crf.canon.fr>
Date: Wed, 20 Oct 1999 10:21:51 +0200 (CEST)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: alois_fertl@TalkNet.de
CC: cort@persephone.cs.nmt.edu, linuxppc-dev@lists.linuxppc.org
In-reply-to: <37B5E009.FBA8C036@talknet.de> (message from Alois Fertl on Sat,
	14 Aug 1999 23:30:50 +0200)
Subject: Re: IDE on Motorola Hardware
References: <37B5E009.FBA8C036@talknet.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Alois" == Alois Fertl <alois_fertl@TalkNet.de> writes:

Alois> Cort, Eric

Hi,

Alois> Some time ago I issued a patch to fix IDE related problems on Motorola
Alois> hardware. This patch was not specific enough and broke the IDE support
Alois> on IBM. Here is a revised version which hopefully will not break other
Alois> systems.

I have my own non generic patch for the MCP750 using the VIA specific driver.
It enables me to put the VIA PCI/ISA bridge at optimal performance...

Thanks for your mail anyway. If you want the patch again, mail me...


-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF - Communication Dept
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
