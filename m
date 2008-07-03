Return-Path: <bsilverman@conceptxdesign.com>
Received: from smtprelay.hostedemail.com (smtprelay0077.hostedemail.com
	[216.40.44.77]) by ozlabs.org (Postfix) with ESMTP id DD159DDF48
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 05:42:16 +1000 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 0951023F7F8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jul 2008 19:25:30 +0000 (UTC)
Received: from filter.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtprelay02.hostedemail.com (Postfix) with SMTP id 5C4902CB4B5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jul 2008 19:25:25 +0000 (UTC)
Received: from [192.168.1.39] (pool-70-22-99-157.balt.east.verizon.net
	[70.22.99.157]) (Authenticated sender: bsilverman@conceptxdesign.com)
	by omf01.hostedemail.com (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jul 2008 19:25:24 +0000 (UTC)
Message-ID: <486D27B9.8090308@conceptxdesign.com>
Date: Thu, 03 Jul 2008 15:25:45 -0400
From: Brian Silverman <bsilverman@conceptxdesign.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Full Linux distributions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm looking for advice into what Linux distributions (rootfs) people are 
using for the PowerPC.

Specifically, I'm currently using busybox for my core rootfs, but I'm 
looking for an alternative that will allow me to:
    - easily add new packages
    - is binary compatible with the PPC405. 440, and Freescale 85xx cores.
    - can be large (compared to the usual embedded devices), say in the 
100MB to 1GB range.  It will sit on an SD card.
    - Can be built/maintained under cygwin, and can generate a ext2 
image (e.g. with gen2extfs)

I've been looking at:
    1) rolling my own
    2) Mainstream distributions (e.g. Debian/Ubuntu have lingering 
support from PowerBook days; Gentoo seems like a possibility)
    3) OpenEmbedded (doesn't seem to currently support cygwin)

Anybody have any preferences based on what they've used?

-- 
Brian Silverman
Concept X, LLC
