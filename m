Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 78CFE67C30
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 04:17:07 +1000 (EST)
Date: Tue, 3 Oct 2006 11:18:12 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: todc must die!
Message-ID: <20061003181812.GA28128@mag.az.mvista.com>
References: <20061003065744.GC29689@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061003065744.GC29689@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 03, 2006 at 04:57:44PM +1000, David Gibson wrote:
> Paulus, please apply to your powerpc git tree.
> 
> powerpc: Remove todc code from ARCH=powerpc
> 
> Apparently we've copied the todc drivers, for various RTCs used in
> embedded machines from ARCH=ppc to ARCH=powerpc, despite the fact that
> it's never used in the latter.  This patch removes it.

Well, its used, its just that the patches that add users are backed up
waiting for the outcome of flatdevtree changes.

> If we ever need these drivers (which we probably shouldn't now the RTC
> class stuff is in), we can transfer them one by one from ARCH=ppc,
> removing from the hideous abomination which is the todc
> "infrastructure".

Yes, the new RTC infrastructure should be used instead.  Copying over
the todc stuff to powerpc was a stop-gap measure whose time has probably
come.

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Mark A. Greer <mgreer@mvista.com>
