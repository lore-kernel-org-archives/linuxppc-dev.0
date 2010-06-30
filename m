Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5D8C7B707E
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 08:55:20 +1000 (EST)
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v1]460EX on-chip SATA driver<resubmisison>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <20100630200325.GD7756@zod.rchland.ibm.com>
References: <201006241327.o5ODRY6m032299@amcc.com>
	<20100630115808.2D9241524EC@gemini.denx.de>
	<3b928476b2fffdcf0694e5436e8a482f@mail.gmail.com>
	<20100630184728.C02D014EBF9@gemini.denx.de>
	<4C2B9831.9020801@pobox.com>
	<20100630200325.GD7756@zod.rchland.ibm.com>
Date: Thu, 01 Jul 2010 00:55:16 +0200
Message-Id: <20100630225516.8F9D3152442@gemini.denx.de>
Cc: linux-ide@vger.kernel.org, Rupjyoti Sarmah <rsarmah@apm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sr@denx.de, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Josh Boyer,

In message <20100630200325.GD7756@zod.rchland.ibm.com> you wrote:
>
> The driver doesn't depend on CONFIG_ATA_SFF in it's Kconfig file, but seems to
> require it at build time.  Isn't that something that needs fixing in the
> driver?

Right.  Next question is if this is really needed for this driver. 

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Copy from one, it's plagiarism; copy from two, it's research.
