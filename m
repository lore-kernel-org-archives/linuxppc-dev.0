To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 8xx_io/uart.c 
In-reply-to: Your message of "Tue, 11 Feb 2003 11:40:45 -0500"
             <3E49278D.3020306@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 12 Feb 2003 10:16:22 +1100
Message-ID: <23407.1045005382@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 11 Feb 2003 11:40:45 -0500, Dan Malek <dan@embeddededge.com> writes:
>You can pull the uart "bugfix" from the 2_4_devel tree now, if you wish.

Whoops, forgot to ask whether you had also examined the need to set the
Local Protect Bit for full duplex mode in fcc_restart()? Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
