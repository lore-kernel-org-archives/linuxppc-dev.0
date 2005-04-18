Return-Path: <pstudencki@yahoo.com>
Received: from web51309.mail.yahoo.com (web51309.mail.yahoo.com
	[206.190.38.175]) by ozlabs.org (Postfix) with SMTP id EE05667B1C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 01:34:44 +1000 (EST)
Message-ID: <20050418153442.83479.qmail@web51309.mail.yahoo.com>
Date: Mon, 18 Apr 2005 08:34:42 -0700 (PDT)
From: Pawel Studencki <pstudencki@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: using initramfs with ppc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
 
I use a custom board with 8xx and kernel 2.6.11 and
try to mount root fs
based on cramfs. I still have problems with mounting
VFS:

VFS: Cannot open root device "mtdblock1" or
unknown-block(31,1)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root
fs on
unknown-block(31,1)

I found, that perhaps the reason is initramfs. How do
you use initramfs on
ppc?
Is it possible to turn off initramfs? If I've
understood correct
"Documentation/early-userspace/README", there is
possibility to boot direct
from flash.

My filesystem for initramfs is very simple in default
"initramfs_list" file:

dir /dev 0755 0 0
nod /dev/console 0600 0 0 c 5 1
dir /root 0700 0 0


do I have to append special files or directories?

thanks for any hints.

regards
Pawel


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 
