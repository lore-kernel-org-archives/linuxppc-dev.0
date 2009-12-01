Return-Path: <tj@kernel.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3F545B7B6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 18:20:54 +1100 (EST)
Message-ID: <4B14C3D1.4010401@kernel.org>
Date: Tue, 01 Dec 2009 16:20:49 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc/macio: Add devres support to macio_device
References: <20091201070832.37EB8B7B65@ozlabs.org>
In-Reply-To: <20091201070832.37EB8B7B65@ozlabs.org>
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

On 12/01/2009 04:08 PM, Benjamin Herrenschmidt wrote:
> This adds some basic devres support. When enabled via macio_enable_devres()
> resources requested by drivers will be automatically released.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
