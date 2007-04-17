Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 4806CDDDF4
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 19:03:50 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 3/4] bootwrapper: Add ppcboot.h. 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 16 Apr 2007 18:25:53 CDT."
	<20070416232553.GB26693@ld0162-tx32.am.freescale.net>
Date: Tue, 17 Apr 2007 11:03:42 +0200
Sender: wd@denx.de
Message-Id: <20070417090342.3E736352658@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20070416232553.GB26693@ld0162-tx32.am.freescale.net> you wrote:
> This file describes the bd_t struct, which is used by old versions of
> U-boot to pass information to the kernel.  Platform code that needs to
> interoperate with such firmware can use this; it should not be used for
> anything new.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/ppcboot.h |  108 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 108 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/ppcboot.h
> 
> diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
> new file mode 100644
> index 0000000..5290ff2
> --- /dev/null
> +++ b/arch/powerpc/boot/ppcboot.h

Shouldn't we finally get this straight and call the file "u-boot.h" as
it is called in U-Boot?

The PPCBoot projects has been discontinued for many years by now...


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The man on tops walks a lonely street;  the  "chain"  of  command  is
often a noose.
