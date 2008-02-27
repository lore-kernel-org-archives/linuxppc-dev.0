Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CC1EDDDEF1
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 01:59:32 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1RExHES004680
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 09:59:17 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1RExGa3214698
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 09:59:16 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1RExGr3013799
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 09:59:16 -0500
Date: Wed, 27 Feb 2008 08:57:54 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 44x: add missing define TARGET_4xx and
	TARGET_440GX to cuboot-taishan.c
Message-ID: <20080227085754.22d09d2b@zod.rchland.ibm.com>
In-Reply-To: <20080226145853.GA18212@ru.mvista.com>
References: <20080224123656.760338da@zod.rchland.ibm.com>
	<20080226145853.GA18212@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Feb 2008 17:58:53 +0300
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> In order to get the proper boad info (bd_info) structure defined in ppcboot.h
> both TARGET_4xx and TARGET_44x should be defined for all PowerPC 440 boards.
> The 440GX boards also need TARGET_440GX defined since they have 4 EMACs and
> there are 4 MAC addesses in bd_info passed by u-boot.

Thanks, looks much better.  I'll send this to Paul later today.

josh
