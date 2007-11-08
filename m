Return-Path: <garzik@gtf.org>
Received: from havoc.gtf.org (havoc.gtf.org [69.61.125.42])
	by ozlabs.org (Postfix) with ESMTP id 0181FDDDE6
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Nov 2007 04:53:54 +1100 (EST)
Date: Thu, 8 Nov 2007 12:47:34 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] pasemi_mac: Don't set replace-source-address
	descriptor bits
Message-ID: <20071108174734.GC3011@havoc.gtf.org>
References: <20071107042001.GC22637@lixom.net>
	<20071107042039.GD22637@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071107042039.GD22637@lixom.net>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 06, 2007 at 10:20:39PM -0600, Olof Johansson wrote:
> Don't use the "replace source address with local MAC address" bits, since
> it causes problems on some variations of the hardware due to an erratum.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

applied 1-2
