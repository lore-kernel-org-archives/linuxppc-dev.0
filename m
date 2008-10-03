Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id A5D63DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Oct 2008 00:37:48 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: vb <vb@vsbe.com>
Subject: Re: EMAC2 in ibm_newemac driver
Date: Fri, 3 Oct 2008 16:37:42 +0200
References: <f608b67d0810012138w64ba5ecbg1f88fff505c820b7@mail.gmail.com>
	<200810020751.42821.sr@denx.de>
	<f608b67d0810022157q464687e6i8162d8f9f6b319dd@mail.gmail.com>
In-Reply-To: <f608b67d0810022157q464687e6i8162d8f9f6b319dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810031637.42968.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Vadim,

On Friday 03 October 2008, vb wrote:
> > The AMCC Glacier 460GT eval board uses all 4 EMAC's with RGMII. IIRC,
> > then you need to configure the GPIO multiplexing differently (compared to
> > Canyonlands 460EX) to fully support all 4 EMAC's on 460GT. This is done
> > in U-Boot. I suggest that you check this configuration first.
>
> Stefan, you are a gentleman and a scholar: this is exactly where my
> problem was. Thank you for saving me from wasting lots of time trying
> to figure out what's 'wrong' with the driver.
>
> Now, comparing glacier GPIO settings with the 460Gx datasheet (rev
> 1.07 of May 29)

That's an old version. I suggest you download the latest users manual. I have 
rev. 1.14 (Sept. 2) here.

> it seems that the datasheet is wrong and suggests 
> using of ALT2 mode for the RGMII2 gpio pins(does not work) as opposed
> ALT1 used in glacier (and actually working apart from a problem I
> still am seeing with the TX). Do you remember anything about this?

I remember that the early manual had some problems. GPIO being only one of 
them. Not sure if this is really fixed in the current manual. But the U-Boot 
code should show what's really correct. Code can't lie! ;)

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
