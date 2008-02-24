Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A5088DDF2F
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Feb 2008 05:37:45 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1OIbKSV005072
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 13:37:20 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1OIbfQr158152
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 11:37:41 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1OIbfLp009377
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Feb 2008 11:37:41 -0700
Date: Sun, 24 Feb 2008 12:36:56 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 44x: add missing define TARGET_4xx to
	cuboot-taishan.c
Message-ID: <20080224123656.760338da@zod.rchland.ibm.com>
In-Reply-To: <20080224093255.7c47a1e2@zod.rchland.ibm.com>
References: <20080221144317.GA19395@ru.mvista.com>
	<20080224093255.7c47a1e2@zod.rchland.ibm.com>
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

On Sun, 24 Feb 2008 09:32:55 -0600
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Thu, 21 Feb 2008 17:43:17 +0300
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
> > In order to get the proper bd_info structure for PowerPC 440,
> > both TARGET_4xx and TARGET_44x should be defined.
> 
> Could you explain what this adds or why it's needed in the changelog?
> Also, is this needed for other 440 boards?

And actually, looking at this more, does taishan also need TARGET_440GX?

josh
