Return-Path: <kumar.gala@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139]) by ozlabs.org (Postfix) with ESMTP id DBDB61007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 04:58:32 +1000 (EST)
Subject: Re: [PATCH][v2] powerpc: rename immap_86xx.h to fsl_guts.h,
	and add 85xx support
MIME-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <20100722164927.GC16119@rakim.wolfsonmicro.main>
Date: Thu, 22 Jul 2010 13:43:00 -0500
Message-ID: <84CE2602-9E81-473B-8E5F-4F4AD0E07484@freescale.com>
References: <1279816410-19079-1-git-send-email-timur@freescale.com>
	<20100722164927.GC16119@rakim.wolfsonmicro.main>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 22, 2010, at 11:49 AM, Mark Brown wrote:

> On Thu, Jul 22, 2010 at 11:33:30AM -0500, Timur Tabi wrote:
>> The immap_86xx.h header file only defines one data structure: the =
"global
>> utilities" register set found on Freescale PowerPC SOCs.  Rename this =
file
>> to fsl_guts.h to reflect its true purpose, and extend it to cover the =
"GUTS"
>> register set on 85xx chips.
>>=20
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>=20
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k=
