Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 818E2DDEC6
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 08:38:26 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1QLcNk6001862
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 16:38:23 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1QLcNn7531504
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 14:38:23 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1QLcM2M022868
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 14:38:22 -0700
Date: Mon, 26 Feb 2007 15:38:22 -0600
To: "Kiran Kumar.A" <kiranf5@lycos.com>
Subject: Re: regarding bcm5461
Message-ID: <20070226213822.GI4396@austin.ibm.com>
References: <20070226055800.HM.0000000000002QM@kiranf5.bos-mail-wwl14.lycos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070226055800.HM.0000000000002QM@kiranf5.bos-mail-wwl14.lycos.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, Feb 26, 2007 at 05:58:00AM -0500, Kiran Kumar.A wrote:
> Hi Linas,
> 
> This is kiran here from Bangalore,India.
> 
> I saw your patch dated feb 16 2007 for bcm5461.

I assume you are refering to "[PATCH 1/12]: sungem_phy: support bcm5461 phy, autoneg."
right?  This patch is originally from Jens Osterkamp, who would be more expert than I.

> I'm working on mpc8548e based board which has a bcm5461 phy configured for fiber mode.
> 
> I'm receiving from the other system if i connect it on lan in "ping". But when i ping from the mpc8548e board which has bcn5461.
> the counters shows error in packet (RUNT errors). Please throw some light on the same.
> I'm using gianfar drivers.

I'm confused -- the gianfar drivers do not make use of the sungem_phy
code, so I do not understand why this patch would affect you. Can you
clarify?

--linas
