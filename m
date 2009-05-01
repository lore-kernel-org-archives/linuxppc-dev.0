Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 02E8FDDEEA
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 09:20:43 +1000 (EST)
To: Feng Kan <fkan@amcc.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 1/2] Added support for Designware SATA controller driver
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1241211767-32697-1-git-send-email-fkan@amcc.com>
References: <1241211767-32697-1-git-send-email-fkan@amcc.com>
Date: Sat, 02 May 2009 01:20:40 +0200
Message-Id: <20090501232040.3E59283420E8@gemini.denx.de>
Cc: Mark Miesfeld <miesfeld@gmail.com>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Feng Kan,

In message <1241211767-32697-1-git-send-email-fkan@amcc.com> you wrote:
> This adds support for the Designware SATA controller.
> 
> Signed-off-by: Feng Kan <fkan@amcc.com>
> Signed-off-by: Mark Miesfeld <miesfeld@gmail.com>
> ---
>  drivers/ata/Kconfig    |   10 +
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_dwc.c | 2053 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2064 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc.c

...
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@amcc.com>");
> +MODULE_DESCRIPTION("DesignWare Cores SATA controller low lever driver");
------------------------------------------------------------^^^^^

Guess that's a typo?

Hmm... that's 2000+ lines of code in a single file. Maybe this should
be split?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
On a clear disk you can seek forever.
