Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id C7CE6DDF35
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 14:59:32 +1000 (EST)
Date: Tue, 15 Jul 2008 14:59:31 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] kill useless SMT code in prom_hold_cpus
Message-ID: <20080715045930.GE20457@bakeyournoodle.com>
References: <20080708223631.GP9594@localdomain>
	<20080715022202.GD20457@bakeyournoodle.com>
	<20080715045551.GV9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080715045551.GV9594@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 11:55:51PM -0500, Nathan Lynch wrote:
 
> sysfs.  (e.g. /sys/devices/system/cpu/cpu0/physical_id)

Hmm okay, sysfs is fine if you're gettign all the way up. I guess if we
have problems in that are we can readd the printf().
 
> The proper place for such a message is in the kernel's smp bringup
> code later on, and/or the code that initializes the various cpu maps.
> The prom_init code should not really be concerned with the kernel's
> NR_CPUS configuration or mapping of logical to physical ids.

Right, care to make this a series and add that ;P

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
