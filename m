Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4824DDED8
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 09:12:56 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1FMChpL001719
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 17:12:43 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1FMChoR210914
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 15:12:43 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1FMCgQo008461
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 15:12:43 -0700
Date: Fri, 15 Feb 2008 16:12:37 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/4]: Respun LMB patches.
Message-ID: <20080215161237.4531e233@zod.rchland.ibm.com>
In-Reply-To: <20080214.141531.169094647.davem@davemloft.net>
References: <20080213.170938.34536425.davem@davemloft.net>
	<38133B3C-75A2-4465-9484-7BF8E7E85D1D@freescale.com>
	<20080214152448.49c69238@zod.rchland.ibm.com>
	<20080214.141531.169094647.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 Feb 2008 14:15:31 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Date: Thu, 14 Feb 2008 15:24:48 -0600
> 
> > I plan on actually testing this on Ebony, Walnut, and Bamboo either
> > later tonight or tomorrow.  I don't expect many issues.
> > 
> > Dave, those above boards would cover the build of PowerPC 4xx CPU cores.
> 
> Ok.

Ok, booted just fine on Ebony (PowerPC 440), Bamboo(PowerPC 440 + FPU),
and Haleakala (PowerPC 405).

josh
