Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45679B711B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Sep 2010 04:55:58 +1000 (EST)
Subject: Re: [PATCH 2/3] PPC: Fix compilation of fsl_rio.c
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100831131055.01e844d3@schlenkerla.am.freescale.net>
Date: Tue, 31 Aug 2010 13:55:38 -0500
Message-Id: <592C789E-5F1D-41A7-AA2C-BA1258CA5FFD@kernel.crashing.org>
References: <1283220922-20369-1-git-send-email-agraf@suse.de>
	<1283220922-20369-3-git-send-email-agraf@suse.de>
	<20100831131055.01e844d3@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: Linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	Alexander Graf <agraf@suse.de>, Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 31, 2010, at 1:10 PM, Scott Wood wrote:

> On Tue, 31 Aug 2010 04:15:21 +0200
> Alexander Graf <agraf@suse.de> wrote:
> 
>> Commit a52c8f52 introduced machine check magic for the RapidIO chip.
>> Unfortunately it was so magical that it used constants that aren't even
>> defined!
>> 
>> This patch bluntly comments out the broken constant's usage. This
>> probably means that said functionality thus doesn't work, but at
>> least it makes it compile for me.
> 
> The MCSR_MASK is actually completely unnecessary -- it doesn't change
> the result of testing bits that are within the mask.
> 
> Multiple patches have been posted for this already, including:
> http://patchwork.ozlabs.org/patch/56135/
> 
> Someone just needs to apply it. :-)

I've got a different version as I don't want to override the mcheck handler.

- k
