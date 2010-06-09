Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6CC6EB7D69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Jun 2010 16:13:34 +1000 (EST)
To: Jon Smirl <jonsmirl@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/2] mpc5200 ac97 gpio reset
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
References: <1276015562-28928-1-git-send-email-emillbrandt@dekaresearch.com>
	<AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com>
Date: Wed, 09 Jun 2010 08:13:30 +0200
Message-Id: <20100609061330.620AC14E867@gemini.denx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@lists.ozlabs.org,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Jon Smirl,

In message <AANLkTimIs90kR5uqhdBQ02oSd94dn08sOITm51Ylrl4-@mail.gmail.com> you wrote:
>
> Would making a change in uboot be a better solution? Eric, can you
> verify if changing uboot also fixes the problem?

To me it seems better if the driver itself does what needs to be done
instead of relying on specific settings that may or may not be done in
U-Boot. Keep in mind that drivers may be loaded as modules, and that
we even see cases where the same port serves multiple purposes by
loading different driver modules (yes, this is not exactly a clever
idea, but hardware designers come up with such solutions).


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The typical page layout program is nothing more  than  an  electronic
light table for cutting and pasting documents.
