Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 589582BEA0
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Nov 2004 04:21:12 +1100 (EST)
In-Reply-To: <D4D14D42-2BC8-11D9-A949-000393DBC2E8@freescale.com>
References: <D4D14D42-2BC8-11D9-A949-000393DBC2E8@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B6F69E73-2C2A-11D9-A28B-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 1 Nov 2004 12:23:15 -0500
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, anton@au.ibm.com,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Added number of PMRs to cpu_specs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 1, 2004, at 12:42 AM, Kumar Gala wrote:

> ..... I figured it better that we keep all such info in a single 
> place, rather than reproducing PVR based checks in multiple places.

I think if a PVR test causes lots of variations to be tested, we should 
add
the information to the cpu tables.  If a PVR test is trivial (like is 
it a 601),
then we just read the PVR and test it.


	-- Dan
