Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 749B1DDF70
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 10:53:47 +1000 (EST)
Date: Wed, 28 May 2008 10:53:47 +1000
To: Meelis Roos <mroos@linux.ee>
Subject: Re: PPC PReP link failure - copy_page, empty_zero_page
Message-ID: <20080528005346.GK20457@bakeyournoodle.com>
References: <Pine.SOC.4.64.0805272022260.869@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.SOC.4.64.0805272022260.869@math.ut.ee>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 27, 2008 at 08:25:43PM +0300, Meelis Roos wrote:
> While compiling the current kernel on prep ppc:
> 
>   MODPOST 703 modules
> ERROR: "copy_page" [fs/fuse/fuse.ko] undefined!
> ERROR: "empty_zero_page" [fs/ext4/ext4dev.ko] undefined!

Try that patch at: http://patchwork.ozlabs.org/linuxppc/patch?id=18710

Fixes it for me.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
