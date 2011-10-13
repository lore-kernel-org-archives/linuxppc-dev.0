Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4350EB71FE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 02:59:24 +1100 (EST)
Message-ID: <4E970AC4.5010707@freescale.com>
Date: Thu, 13 Oct 2011 10:59:00 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
References: <1316806370-21067-1-git-send-email-agust@denx.de>	<6EFB6D12-7505-4D3E-8FF9-033EF74FFB81@kernel.crashing.org>	<CAOZdJXUWiatadSCmCAvMRrVjVKCJb0xo+XGsF=Rz5-Smp08tMA@mail.gmail.com>	<6F5815DD-DBF0-4155-94CE-FEDC2C9802E1@kernel.crashing.org>	<4E970528.8080908@freescale.com>
 <20111013175026.1479c674@wker>
In-Reply-To: <20111013175026.1479c674@wker>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anatolij Gustschin wrote:
> there is no 32bit address map DTS file for P1022DS in the mainline
> tree. A proper patch should then also add appropriate 32bit address
> map DTS file. I'm not in the position to do it currently since it would
> require testing, I do not have this board to test patches for it.

The defconfig already enables CONFIG_PHYS_64BIT for the P1022DS and all other
85xx parts.  If you look at the Kconfig, you'll see that most boards don't
enable it.  So by default, everything is 64-bit capable.

Adding the Kconfig option will *prevent* anyone from creating a 32-bit kernel.
This is my problem with the patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
