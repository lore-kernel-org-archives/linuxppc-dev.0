Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E39C2DE12D
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 06:08:55 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3NK8L0B001882
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 14:08:21 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3NK8rU6061836
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 14:08:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3NK8qYO005312
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 14:08:52 -0600
Date: Thu, 23 Apr 2009 16:07:49 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC: 440EPx/GRx Sequoia/Rainier U-Boot incorrect
	chipselect number workaround
Message-ID: <20090423200749.GJ3825@zod.rchland.ibm.com>
References: <20090423171222.GA32326@ru.mvista.com>
	<49F0A957.5080508@harris.com> <49F0C9D7.1070707@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F0C9D7.1070707@ru.mvista.com>
Cc: sr@denx.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 24, 2009 at 12:04:39AM +0400, Valentine wrote:
> Thanks Steven,
> Yes, both patches have to be applied.
> Sorry, I missed a trailing space in the comment.
> I'll resubmit another one in a bit.
> Thanks,
> Val.

Could you roll both patches into one, and include Steven's signed-off-by?  That
way I only have a single patch to apply.

josh
