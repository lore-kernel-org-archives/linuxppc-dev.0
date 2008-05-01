Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 524ADDDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 19:05:30 +1000 (EST)
In-Reply-To: <20080501043737.892888612@au1.ibm.com>
References: <20080501042949.237603158@au1.ibm.com>
	<20080501043737.892888612@au1.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <742b5895cdf9b898ec2b4834926a41ac@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] [POWERPC] Move device_to_mask() to dma-mapping.h
Date: Thu, 1 May 2008 11:04:30 +0200
To: markn@au1.ibm.com
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Move device_to_mask() to dma-mapping.h because we need to use it from
> outside dma_64.c in a later patch.

Why does this need to become an inline function?


Segher
