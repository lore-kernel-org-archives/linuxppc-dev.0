Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 12340DE06F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jul 2008 00:33:23 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so3172395wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Jul 2008 07:33:21 -0700 (PDT)
Date: Wed, 9 Jul 2008 08:33:18 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: neeraj garg <neerajg@cdac.in>
Subject: Re: Booting ML405 (Kernel panic - not syncing: No init found)
Message-ID: <20080709143318.GB26524@secretlab.ca>
References: <48744475.2080605@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48744475.2080605@cdac.in>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 09, 2008 at 10:24:13AM +0530, neeraj garg wrote:
> Hi,
>
> I am trying to boot ML405 with Linux source code downloaded from  
> http://www.git.xilinx.com . My cross compiler tool chain version is  
> gcc-3.4.1, glibc-2.3.2 and binutils-2.15. I have also downloaded RAMDISK  
> from same url (http://www.git.xilinx.com). When I download  
> zImage.initrd.elf using XMD everything goes fine, untill RAMDISK is  
> uncompressed, I get following messages :
>
<snip>
>                                           [    3.736691] Failed to  
> execute /sbin/init.  Attempting defaults...
> [    3.748073] Kernel panic - not syncing: No init found.  Try passing  
> init= option to kernel.
> [    3.772040] Rebooting in 180 seconds..[  183.487314]   Signal: 8
>

Try changing the kernel parameters line to specify init=/bin/sh and see
what happens.

g.
