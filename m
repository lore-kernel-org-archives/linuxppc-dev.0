MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: linuxppc_2_4_mpc5200 / 5200lite zImage now working
Date: Thu, 6 Nov 2003 08:48:39 +0100
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED447034@ratatosk.combitechsystems.com>
From: "Tord Andersson" <Tord.Andersson@combitechsystems.com>
To: "Kate Alhola" <kate@iti.fi>, "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kate,

Thanks for sharing your experiences with the MPC5200Lite card.
Would it be possible for you to explain the steps you took to replace
dbug with u-boot. Did you use dbug or a bdm?
I am about to do the same thing, and fear that I might end up with a
"dead" card if
things go wrong : )

Kind regards,

Tord Andersson

-----Original Message-----
From: Kate Alhola [mailto:kate@iti.fi]
Sent: den 2 november 2003 20:13
To: Wolfgang Denk
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_mpc5200 / 5200lite zImage now working



Thank you about usefull help, it looks a like doing things in newer way
may be faster than do older way ;)

Wolfgang Denk wrote:

>No. It's much more likely that you missed to pass  someother  of  the
>required  information.  You  have  several options: manually set up a
>bd_info structure with _all_ of the required  information;  modifying
>U-Boot  so  that  you  can load and start U-Boot from RAM; installing
>U-Boot into flash.
>
>
This worked with u-boot, setting CFG_RAMBOOT made it bootting from RAM
and allowed also programming u-boot to same flash as dbug so now i can
start uboot from dbug and then boot linux up

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
