Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee [193.40.5.67])
	by ozlabs.org (Postfix) with ESMTP id 405BEDDF62
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 03:57:04 +1000 (EST)
Date: Wed, 28 May 2008 20:57:01 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: PPC PReP link failure - copy_page, empty_zero_page
In-Reply-To: <20080528005346.GK20457@bakeyournoodle.com>
Message-ID: <Pine.SOC.4.64.0805282056290.15441@math.ut.ee>
References: <Pine.SOC.4.64.0805272022260.869@math.ut.ee>
	<20080528005346.GK20457@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > ERROR: "copy_page" [fs/fuse/fuse.ko] undefined!
> > ERROR: "empty_zero_page" [fs/ext4/ext4dev.ko] undefined!
> 
> Try that patch at: http://patchwork.ozlabs.org/linuxppc/patch?id=18710
> 
> Fixes it for me.

Yes, this fixes it, thanks! Hopefully it is merged before 2.6.26.

-- 
Meelis Roos (mroos@linux.ee)
