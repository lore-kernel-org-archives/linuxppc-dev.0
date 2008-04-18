Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 69804DE12D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 02:39:01 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 44x: Add NOR flash entry to Canyonlands DTS.
Date: Fri, 18 Apr 2008 18:38:54 +0200
References: <20080417193744.GA17524@ru.mvista.com>
	<200804181626.09585.sr@denx.de> <4808BC33.7070109@ru.mvista.com>
In-Reply-To: <4808BC33.7070109@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804181838.54673.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 18 April 2008, Valentine Barshak wrote:
> > Right, I forgot to add this. But the partition names and sizes are a
> > little different from those we used before (e.g. kilauea). I'll send a
> > patch to update the Canyonlands & Glacier dts files in a short while.
>
> I've got these partition names and sizes form amcc site.
> They seem to correspond to u-boot environment my board has.

I see. I'll check with AMCC on what really to use here.

> Are these incorrect?

Yes, these values are incorrect because of some problems with NOR FLASH on the 
first preliminary board ports. This is fixed now.

I'll come up with some new patches shortly.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
