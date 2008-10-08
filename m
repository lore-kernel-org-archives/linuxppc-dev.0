Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by ozlabs.org (Postfix) with ESMTP id 82306DE784
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 03:15:20 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4196375wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 08 Oct 2008 09:15:20 -0700 (PDT)
Message-ID: <fa686aa40810080915v38a1c40cs7cac3825ee5a7bac@mail.gmail.com>
Date: Wed, 8 Oct 2008 10:15:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc: 5121: Add PCI support.
In-Reply-To: <4800D7D4-28BC-435A-9858-8FAF41F38468@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1223413998-15577-1-git-send-email-jrigby@freescale.com>
	<4800D7D4-28BC-435A-9858-8FAF41F38468@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 8, 2008 at 6:38 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Oct 7, 2008, at 4:13 PM, John Rigby wrote:
>
>> Uses mpc83xx_add_bridge in fsl_pci.c
>>
>> Adds second register tuple to pci node register property
>> as done for 83xx device trees in a previous patch.
>>
>> Signed-off-by: John Rigby <jrigby@freescale.com>
>> ---
>> arch/powerpc/boot/dts/mpc5121ads.dts      |    3 ++-
>> arch/powerpc/platforms/512x/Kconfig       |    2 ++
>> arch/powerpc/platforms/512x/mpc5121_ads.c |   10 ++++++++++
>> arch/powerpc/sysdev/fsl_pci.c             |    4 ++--
>> 4 files changed, 16 insertions(+), 3 deletions(-)
>
> Acked-by: Kumar Gala <galak@kernel.crashing.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
