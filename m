Return-Path: <jgpobox@gmail.com>
Received: from mail-qa0-x229.google.com (mail-qa0-x229.google.com
 [IPv6:2607:f8b0:400d:c00::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C534D2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 May 2013 07:35:47 +1000 (EST)
Received: by mail-qa0-f41.google.com with SMTP id hg5so1827833qab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 14:35:43 -0700 (PDT)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <5180392D.1000103@pobox.com>
Date: Tue, 30 Apr 2013 17:35:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Anthony Foiani <tkil@scrye.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com> <4FC50F22.2040404@freescale.com>
 <gvcjetze3.fsf@dworkin.scrye.com> <4FC5546A.4090506@freescale.com>
 <gd35lbf55.fsf@dworkin.scrye.com> <517F67AD.2010101@scrye.com>
In-Reply-To: <517F67AD.2010101@scrye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>, Scott Wood <scottwood@freescale.com>,
 "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/30/2013 02:41 AM, Anthony Foiani wrote:
> Apologies for resurrecting a very old thread, but...
>
> On 05/30/2012 02:14 PM, Anthony Foiani wrote:
>>
>> Maybe someone who knows devtree really well could crank that out in a
>> few minutes... but I'm not that person.  :)
> Well, I wasn't last year, but this year I decided that I didn't care.
> Took me about an hour, not a minute, but...
>
> Having been bitten by this config symbol disappearing one more time,
> please find attached my attempt at using information out of the device
> tree to enable this hack.
>
> Patch is against 3.4.36 or so; hopefully upstream hasn't diverged very
> much.
>
> Tested by me, so feel free to add that tag if required.

Regarding this patch:  Search for "sata_spd_limit" and xxx_spd* functions

	Jeff
