Message-ID: <3D345816.EF88C2D3@esteem.com>
Date: Tue, 16 Jul 2002 10:29:58 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Jim Lin <jimmlin@solomon.com.tw>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Poor 8xx SCC Ethernet mode performence..
References: <NFBBLLKCILMGHKJGDFGHEEMACCAA.jimmlin@solomon.com.tw>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim Lin wrote:
>
> Hi .
>
> I  was testing SCC ethernet performance at our 850 custom board and found somting interesting.
>
> 1. Tested FTP  Transfer about 20MB file with 10T hub  I got  about 250 k bps (someting poor ..)
> 2. and I found the hhl20 arch/ppc/8xx_io/enet.c source code NOT enable full duplex ..
>      and I had  pmsr  added SCC_PMSR_FDE | SCC_PMSR_LPB .. and compiling , tested FTP Transfer again.
>      I got about 200 Kbps!
>
> I do not understand what is happen? Has anyone experience this?
>

I know for a fact that the 850 can do 10Mbits .  Check and see what the download
rate is from your ftp host using a different computer. Your 850 board should be
about the same speed.

If your 850 board isn't try looking at the Tx and Rx ethernet data lines with an
oscilliscope. If the activity on the lines seems to corespond to the with the
datarate you have a software problem. If the activity is signifigantly greater
you probably have a analog problem. Double check the turns ratio on your magnet
and make sure it is what your phy needs.

Good luck

	Conn

--

*****************************************************************
  If you live at home long enough, your parents will move out.
 (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
