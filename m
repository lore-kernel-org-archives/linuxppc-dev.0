Return-Path: <rsarmah@apm.com>
Received: from exprod5og111.obsmtp.com (exprod5og111.obsmtp.com [64.18.0.22])
	by ozlabs.org (Postfix) with SMTP id 5FF9A1007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jul 2010 03:44:18 +1000 (EST)
Received: by wyb33 with SMTP id 33so306275wyb.39
	for <linuxppc-dev@ozlabs.org>; Thu, 01 Jul 2010 10:44:15 -0700 (PDT)
From: Rupjyoti Sarmah <rsarmah@apm.com>
References: <201006241327.o5ODRY6m032299@amcc.com>
	<20100630115808.2D9241524EC@gemini.denx.de>
	<3b928476b2fffdcf0694e5436e8a482f@mail.gmail.com>
	<20100630184728.C02D014EBF9@gemini.denx.de>
	<4C2B9831.9020801@pobox.com>
	<20100630200325.GD7756@zod.rchland.ibm.com>
	<20100630225516.8F9D3152442@gemini.denx.de>
In-Reply-To: <20100630225516.8F9D3152442@gemini.denx.de>
MIME-Version: 1.0
Date: Thu, 1 Jul 2010 23:14:14 +0530
Message-ID: <4645a5c409da26358f3102276bbccf72@mail.gmail.com>
Subject: RE: [PATCH v1]460EX on-chip SATA driver<resubmisison>
To: Wolfgang Denk <wd@denx.de>, Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Jeff Garzik <jgarzik@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, sr@denx.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear All,

The Synopsis design ware core is task file orientated so the driver would
still need CONFIG_ATA_SFF.
I would be fixing the Kconfig file to make it dependent on the
CONFIG_ATA_SFF.

Regards,
Rup



-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thursday, July 01, 2010 4:25 AM
To: Josh Boyer
Cc: Jeff Garzik; linux-ide@vger.kernel.org; sr@denx.de; Rupjyoti Sarmah;
linux-kernel@vger.kernel.org; linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v1]460EX on-chip SATA driver<resubmisison>

Dear Josh Boyer,

In message <20100630200325.GD7756@zod.rchland.ibm.com> you wrote:
>
> The driver doesn't depend on CONFIG_ATA_SFF in it's Kconfig file, but
seems to
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
