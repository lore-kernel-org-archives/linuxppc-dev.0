Message-ID: <3FA55727.8040803@iti.fi>
Date: Sun, 02 Nov 2003 21:12:39 +0200
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_mpc5200 / 5200lite zImage now working
References: <20031102155604.35E0AC5F59@atlas.denx.de>
In-Reply-To: <20031102155604.35E0AC5F59@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you about usefull help, it looks a like doing things in newer way
may be
faster than do older way ;)

Wolfgang Denk wrote:

>No. It's much more likely that you missed to pass  someother  of  the
>required  information.  You  have  several options: manually set up a
>bd_info structure with _all_ of the required  information;  modifying
>U-Boot  so  that  you  can load and start U-Boot from RAM; installing
>U-Boot into flash.
>
>
This worked with u-boot, setting CFG_RAMBOOT made it bootting from
RAM and allowed also programming u-boot to same flash as dbug so now
i can start uboot from dbug and then boot linux up

>You can always get a tested and working configuration  by  performing
>the standard kernel build procedure:
>
>	bash$ make mrproper
>	bash$ make icecube_5200_config
>	bash$ make oldconfig
>	bash$ make dep
>	bash$ make uImage
>
>
Tanks, that was also usefull

Kate


--
+==================================================================+
! Kate Marika Alhola  Internet Technologies International Oy       !
! kate@iti.fi         Phone +358 400 740701 Fax   +358 9 8138715   !
! kate@iki.fi	      http://www.iti.fi    http://www.iki.fi/kate  !
+==================================================================+


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
