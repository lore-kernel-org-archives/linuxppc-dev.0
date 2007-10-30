Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2E20DE0FC
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 15:17:31 +1100 (EST)
Subject: Re: [PATCH] [Powerpc V2] fix switch_slb handling of 1T ESID values
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
In-Reply-To: <20071029183218.19914.51410.stgit@farscape.rchland.ibm.com>
References: <20071029183218.19914.51410.stgit@farscape.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 30 Oct 2007 15:17:24 +1100
Message-Id: <1193717844.9928.60.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-10-29 at 13:32 -0500, Will Schmidt wrote:
> [Powerpc V2] fix switch_slb handling of 1T ESID values
> 
> Now that we have 1TB segment size support, we need to be using the
> GET_ESID_1T macro when comparing ESID values for pc,stack, and
> unmapped_base within switch_slb().    A new helper function called
> esids_match() contains the logic for deciding when to call GET_ESID
> and GET_ESID_1T.
> 
> This also happens to fix a duplicate-slb-entry inspired machine-check
> exception I was seeing when trying to run java on a power6 partition.
> 
> Tested on power6 and power5.
> 
> Signed-Off-By:  Will Schmidt <will_schmidt@vnet.ibm.com>
> ---

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
