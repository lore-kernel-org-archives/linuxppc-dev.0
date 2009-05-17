Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 35F90DE066
	for <linuxppc-dev@ozlabs.org>; Sun, 17 May 2009 23:34:23 +1000 (EST)
To: Konstantin Baydarov <kbaidarov@ru.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] [PowerPC] Support For Initrd Loaded Into Highmem
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4A103EDF.7050108@ru.mvista.com>
References: <4A103EDF.7050108@ru.mvista.com>
Date: Sun, 17 May 2009 15:34:17 +0200
Message-Id: <20090517133417.9E0FC832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Konstantin Baydarov,

In message <4A103EDF.7050108@ru.mvista.com> you wrote:
> 
>   It turned out that:
> PPC uBoot always loads initrd image at the highest RAM address. So if board has

Please read the documentation, for example the U-Boot  README  -  pay
speicial  attention  to  the section that discusses the "initrd_high"
envrionment variable.

>   How Solved:
> Code was added that checks if initrd is in the highmem and relocates initrd
> into lowmem if required.

I don't think this is needed. Just don't load the ramdisk to highmem
in the first place.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
How come everyone's going so slow if it's called rush hour?
