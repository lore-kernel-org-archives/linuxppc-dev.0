Return-Path: <SRS0=FKTu=AN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29BEC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 19:07:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84111206A1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 19:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84111206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ySJL5k34zDqQN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 05:06:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=pierre-louis.bossart@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none)
 header.from=linux.intel.com
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49ySDz4hn0zDqpy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2020 05:04:02 +1000 (AEST)
IronPort-SDR: 0A+jSPJq3Mm4ctJCktG+SgQRiZD8qb/QCiObWBkWAjCYlhrWXpdnmF+te/ZgJ2lExPnZ4zyE+K
 MINNinEh5kaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="165054875"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="165054875"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:04:00 -0700
IronPort-SDR: gnOBcBliBICPHYLlTAPB2fAVH+V8bYokR4W/N0dEdoSDStXp83ufUbFjAeqPKRu7wvhjleJ1g5
 aUDy828pShMw==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="295989116"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO [10.254.75.219])
 ([10.254.75.219])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:03:59 -0700
Subject: Re: [PATCH 6/6] ASoC: fsl: fsl_esai: fix kernel-doc
To: Nicolin Chen <nicoleotsuka@gmail.com>
References: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
 <20200702172227.164474-7-pierre-louis.bossart@linux.intel.com>
 <20200702185556.GG23935@Asurada-Nvidia>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2191ccbf-5c94-62e5-33b0-635284e5a8c6@linux.intel.com>
Date: Thu, 2 Jul 2020 14:03:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702185556.GG23935@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, tiwai@suse.de,
 "open list:FREESCALE SOC SOUND DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, broonie@kernel.org,
 Fabio Estevam <festevam@gmail.com>, open list <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 7/2/20 1:55 PM, Nicolin Chen wrote:
> On Thu, Jul 02, 2020 at 12:22:27PM -0500, Pierre-Louis Bossart wrote:
>> Fix W=1 warnings. Fix kernel-doc syntax and add missing parameters.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
>> + * fsl_esai_set_dai_sysclk - This function mainly configures the clock frequency of MCLK (HCKT/HCKR)
> 
> Can drop "This function mainly"
> 
>>   /**
>> - * This function configures the related dividers according to the bclk rate
>> + * fsl_esai_set_bclk - This function configures the related dividers according to the bclk rate
> 
> Here too -- dropping "This function"

will fix both, thanks for reviewing the edits.

> 
> Otherwise,
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> Thanks!
> 
