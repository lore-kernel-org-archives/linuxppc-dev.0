Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A36ADDDF5
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 04:46:55 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l4MIgtSs024065
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 14:42:55 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4MIkhPH247480
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 12:46:43 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4MIkhu8027526
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 12:46:43 -0600
Date: Tue, 22 May 2007 13:46:32 -0500
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Subject: Re: [PATCH] powerpc 2.6.21-rt6: revert spider_net
Message-ID: <20070522184632.GL5921@austin.ibm.com>
References: <yyi646l6pmr.wl@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yyi646l6pmr.wl@toshiba.co.jp>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 22, 2007 at 08:53:32PM +0900, Tsutomu OWA wrote:
> 
> Hi Ingo and Thomas,
>
> To revert spider_net.c to original one as it turns out that the patch 

As the spidernet maintainer, I had not forwarded the previous patch
upstream; it should not have been applied.

--linas
