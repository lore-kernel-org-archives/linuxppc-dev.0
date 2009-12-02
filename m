Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB33F1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 12:07:23 +1100 (EST)
Message-ID: <4B15BDCF.5020000@kernel.org>
Date: Wed, 02 Dec 2009 10:07:27 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio,
	driver Apple PowerMac/PowerBook IDE controller
References: <20091202003630.29919100851@ozlabs.org>
In-Reply-To: <20091202003630.29919100851@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/02/2009 09:36 AM, Benjamin Herrenschmidt wrote:
> This is a libata driver for the "macio" IDE controller used on most Apple
> PowerMac and PowerBooks. It's a libata equivalent of drivers/ide/ppc/pmac.c
> 
> It supports all the features of its predecessor, including mediabay hotplug
> and suspend/resume. It should also support module load/unload.
> 
> The timing calculations have been simplified to use pre-calculated tables
> compared to drivers/ide/pmac.c and it uses the new mediabay interface
> provided by a previous patch.

Other than the media bay locking thing I mentioned before, it looks
good to me and the media bay thing can be dealth with further patches,
so...

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
