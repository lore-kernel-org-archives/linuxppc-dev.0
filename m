Message-ID: <3F5EE616.2070305@iti.fi>
Date: Wed, 10 Sep 2003 11:51:34 +0300
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC8245 supported in Linux kernel (devel tree from DENX)?
References: <20030910080020.14B11C59E4@atlas.denx.de>
In-Reply-To: <20030910080020.14B11C59E4@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>Dear Shawn,
>
>in message <9153F74610B7D311B83900902771C871124D94BC@axcs07.cos.agilent.com> you wrote:
>
>
>>Is MPC8245 supported in the linux kernel downloaded from the devel tree of DENX? I only found six types of processors supported by default, which are 6xx/7xx/74xx/8260, 40x, 440, POWER3, 8xx, and iSeries. If yes, which type shall I select? If not, is th
>>ere anybody going to support this? U-Boot seems to support this by 824x.
>>
>>
>
>The MPC8245 is supported by the Linux kernel, too.  Please  configure
>for  a  standard 6xx CPU (CONFIG_PPC=y, CONFIG_PPC32=y, CONFIG_6xx=y,
>CONFIG_PPC_STD_MMU=y).
>
>
How about internal PCI bridge support for 8xxx series ? I have tried
found it for
826x/825x/8270 QUCC-II but it seems that there is just promises around
but i have not
even found souce of development/alpha version.

Least as my view as both HW/SW engineer it is one of most essential parts
needed for functional system because it just is not practical attach any
extra
IO etc in high speed SDRAM bus.

Kate


--
+==================================================================+
! Kate Marika Alhola  Internet Technologies International Oy       !
! kate@iti.fi         Phone +358 400 740701 Fax   +358 9 8138715   !
! kate@iki.fi	      http://www.iti.fi    http://www.iki.fi/kate  !
+==================================================================+


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
