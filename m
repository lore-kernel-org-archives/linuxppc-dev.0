Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 76137B6F08
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 05:29:05 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o06IT2TT018632
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jan 2010 11:29:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o06IY4W0028727
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Jan 2010 12:34:04 -0600 (CST)
Message-ID: <4B44D5FF.5050505@freescale.com>
Date: Wed, 06 Jan 2010 12:27:11 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH 7/8] fsldma: rename fsl_chan to fchan
References: <1262326246-936-1-git-send-email-iws@ovro.caltech.edu>
	<1262326246-936-8-git-send-email-iws@ovro.caltech.edu>
	<20100106180422.GB27146@loki.buserror.net>
	<20100106181933.GB26426@ovro.caltech.edu>
In-Reply-To: <20100106181933.GB26426@ovro.caltech.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: herbert@gondor.apana.org.au, B04825@freescale.com, linuxppc-dev@ozlabs.org,
	Vishnu@freescale.com, Dipen.Dudhat@freescale.com,
	dan.j.williams@intel.com, Maneesh.Gupta@freescale.com, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira W. Snyder wrote:
> On Wed, Jan 06, 2010 at 12:04:22PM -0600, Scott Wood wrote:
>> On Thu, Dec 31, 2009 at 10:10:45PM -0800, Ira W. Snyder wrote:
>>> The name fsl_chan seems too long, so it has been shortened to fchan.
>> Could be just "chan", no need for namespacing here.
>>
> 
> True. A few functions have a parameter "struct dma_chan *chan" from the
> DMAEngine API. I tried to keep the name different to avoid confusing
> readers of the code.

Ah, I see.

I suppose "fchan" is OK in that case, or "priv", or call the dma_chan 
"dchan", etc.

-Scott
