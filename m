Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s38.bay0.hotmail.com (bay0-omc1-s38.bay0.hotmail.com
	[65.54.246.110]) by ozlabs.org (Postfix) with ESMTP id A1FB667BA7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 01:28:35 +1000 (EST)
Message-ID: <BAY110-F24ECE4A31BC21F098B510B24B0@phx.gbl>
In-Reply-To: <44DC9ECF.7030301@mdivac.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: lombardo@mdivac.com
Subject: Re: U-boot on ML403
Date: Fri, 11 Aug 2006 15:28:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Frank,
So you mean, you built your ML403 system with U-Boot supported according to 
the updated version of xapp542, right? There are NOT some patches open to 
everyone to include ML403 support into the U-Boot tree, right? 

If both answers for the two questions are yes, then I have to contact 
Xilinx to ask for help. Anyway, thanks for your information and reply. 

Regards
Ming


>From: Frank D Lombardo <lombardo@mdivac.com>
>To: Ming Liu <eemingliu@hotmail.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: U-boot on ML403
>Date: Fri, 11 Aug 2006 11:14:23 -0400
>
>Ming Liu wrote:
> > Dear Frank,
> > I know you are using U-boot on ML403 now. So can you say something
> > about how to configure U-boot as ML403 board? I noticed that in U-boot
> > 1.1.4, there is only ML300 supported. So if I want to configure the
> > board as ML403 and some other customed options(e.g. no EEPROM), what
> > shall I do? Thanks for your help.
> >
> > Regards
> > Ming
> >
>
>Ming,
>
>I received an updated version of the Xilinx xapp542 directly from
>Xilinx. We had to sign a non-disclosure agreement before they would send
>it to me. This update provided the necessary pieces to allow XPS to
>generate a U-Boot "BSP" and a modified U-Boot tree with support for
>additional mlXXX boards.
>
>I would recommend contacting Xilinx for this. Sorry I can't be of
>greater assistance.
>
>Frank
>

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
