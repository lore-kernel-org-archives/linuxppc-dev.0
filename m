Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AB49DDDE47
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 02:35:49 +1000 (EST)
Message-ID: <4624F75C.8060606@freescale.com>
Date: Tue, 17 Apr 2007 11:35:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 3/4] bootwrapper: Add ppcboot.h.
References: <20070417090342.3E736352658@atlas.denx.de>
In-Reply-To: <20070417090342.3E736352658@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> In message <20070416232553.GB26693@ld0162-tx32.am.freescale.net> you wrote:
>>diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
>>new file mode 100644
>>index 0000000..5290ff2
>>--- /dev/null
>>+++ b/arch/powerpc/boot/ppcboot.h
> 
> 
> Shouldn't we finally get this straight and call the file "u-boot.h" as
> it is called in U-Boot?

Probably...  though the ppcboot.h name does reinforce the legacy nature 
of the interface.  Maybe old-u-boot.h?

Paul, feel free to change the name of the file in the patch if you want.

-Scott
