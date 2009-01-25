Return-Path: <linux.matthew@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 20ABCDE0C3
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 06:16:05 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so1893743nfd.9
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jan 2009 11:16:03 -0800 (PST)
Message-ID: <497CB8C3.5080907@gmail.com>
Date: Sun, 25 Jan 2009 14:08:51 -0500
From: Matthew Clark <linux.matthew@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: What are the default VMA maps for linux on PPC32?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is there a good source that lists the standard virtual address mappings 
of the various components of linux?  I know the kernel starts at 
0xC000_0000 and user apps start at 0x1000_0000, but things like shared 
objects are much less clear.  For example, the smap entry for my ntpd 
process shows two distinct areas of usage: ~0xf000_0000 and 
~0x3000_0000, but I have no idea what's where and why.  Can anyone shed 
some light on this?  Thanks.

Matt

0fbde000-0fbe2000 r-xp 00000000 00:0c 905394     /lib/libnss_dns-2.3.6.so
0fbe2000-0fbf1000 ---p 00004000 00:0c 905394     /lib/libnss_dns-2.3.6.so
0fbf1000-0fbf2000 r--p 00003000 00:0c 905394     /lib/libnss_dns-2.3.6.so
0fbf2000-0fbf3000 rwxp 00004000 00:0c 905394     /lib/libnss_dns-2.3.6.so
0ffba000-0ffbe000 rwxp 0012a000 00:0c 905395     /lib/libc-2.3.6.so
0ffd0000-0ffe7000 r-xp 00000000 00:0c 905370     /lib/ld-2.3.6.so
0fff6000-0fff7000 r--p 00016000 00:0c 905370     /lib/ld-2.3.6.so
0fff7000-0fff8000 rwxp 00017000 00:0c 905370     /lib/ld-2.3.6.so
 
30009000-3001e000 r-xp 00000000 00:0c 1323564    /usr/lib/libelf-0.108.so
3001e000-3002d000 ---p 00015000 00:0c 1323564    /usr/lib/libelf-0.108.so
3002d000-3002e000 rwxp 00014000 00:0c 1323564    /usr/lib/libelf-0.108.so
