Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id D522CB6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 08:55:17 +1100 (EST)
To: smitha.vanga@wipro.com
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Mac address in the DT
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
In-reply-to: <40631E9A2581F14BA60888C87A76A1FE01D3F2@HYD-MKD-MBX4.wipro.com>
References: <40631E9A2581F14BA60888C87A76A1FE01D3F2@HYD-MKD-MBX4.wipro.com>
Date: Tue, 10 Jan 2012 22:55:09 +0100
Message-Id: <20120110215509.2D08D1167AA4@gemini.denx.de>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear smitha.vanga@wipro.com,

In message <40631E9A2581F14BA60888C87A76A1FE01D3F2@HYD-MKD-MBX4.wipro.com> you wrote:
>  
> The fdt_fixup_ethernet() is not supported in the older version of u-boot. So
>  how to go about it in u-boot 1.3.0 version.

U-Boot v1.3.0 is more than 4 years old.

Update, or restrict yourself to using 4 years old Linux kernel
versions as well, like v2.6.23 or so :-(

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Everyting looks interesting until you do it. Then you find it's  just
another job.                     - Terry Pratchett, _Moving Pictures_
