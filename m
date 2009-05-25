Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id BDB3CDDFE4
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 16:15:44 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M8TTJ-00048M-Nb
	for linuxppc-dev@ozlabs.org; Sun, 24 May 2009 23:15:41 -0700
Message-ID: <23701685.post@talk.nabble.com>
Date: Sun, 24 May 2009 23:15:41 -0700 (PDT)
From: konamo <dai.michael@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: AMCC 405ex memory size issue
In-Reply-To: <23631525.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <23631525.post@talk.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


any ideas?



konamo wrote:
> 
> Hi all,
>   we are using AMCC 405ex kilauea eval board as a demo, not use any
> pci/nand function, 
> the board configuration is below:
> u-boot 2009.01, 
> linux-2.6.25-rc2, 
> 1GB DDR2 memory(2Gbit * 4, 1 rank), 
> AMCC powerpc 405ex, 
> both 1G and 512MB memory works fine under u-boot, but linux boot fails in
> 1G memory, if we limit mem=512M, linux could boot over nfs. Could anyone
> pls help us how to find the root cause? thanks
> 

-- 
View this message in context: http://www.nabble.com/AMCC-405ex-memory-size-issue-tp23631525p23701685.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
