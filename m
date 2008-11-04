Return-Path: <mcrane@fusionio.com>
Received: from mx1.fusionio.com (mx1.fusionio.com [64.244.102.30])
	by ozlabs.org (Postfix) with ESMTP id 21479DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Nov 2008 05:50:36 +1100 (EST)
Received: from zim.fusionio.com (localhost [127.0.0.1])
	by mx1.fusionio.com (Spam Firewall) with ESMTP id 380C156434
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 11:32:22 -0700 (MST)
Received: from zim.fusionio.com ([10.101.1.182]) by mx1.fusionio.com with
	ESMTP id E9VHHi1HgXGGIh3H for <linuxppc-embedded@ozlabs.org>;
	Tue, 04 Nov 2008 11:32:22 -0700 (MST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zim.fusionio.com (Postfix) with ESMTP id 3D45B4500002
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 11:32:22 -0700 (MST)
Received: from zim.fusionio.com ([127.0.0.1])
	by localhost (zim.fusionio.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EtX-ip7pT4Gf for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 11:32:14 -0700 (MST)
Received: from mcrane.int.fusionio.com (unknown [64.244.102.2])
	by zim.fusionio.com (Postfix) with ESMTP id E00104500001
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Nov 2008 11:32:14 -0700 (MST)
Message-Id: <385918C0-E800-4DA0-92F3-2755BCEB7434@fusionio.com>
From: Mitch Crane <mcrane@fusionio.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: booting 32 bit kernel on G5
Date: Tue, 4 Nov 2008 11:32:10 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

First off, I apologize for not searching the archives, I'm afraid the  
link is broken: http://lists.linuxppc.org/rules.html

My AMCC Katmai is on order.  In the meantime I'd like to try building  
and running my driver on my Mac G5 PPC64, running in 32 bit mode.  I  
have a recent YDL distro installed, and can rebuild the kernel,  
switching off 64 bit in the kernel build config.  However, when I try  
to boot the 32 bit kernel it hangs in the open firmware "release keys  
to continue" screen.  Can someone please lend a hand here?  Has anyone  
accomplished a 32 bit boot on a Mac G5 with a 2.6 kernel?

thank you!
Mitch.


CONFIDENTIAL

This document and attachments contain information from Fusion-io, Inc. which is confidential and/or legally privileged. 
The information is intended only for the use of the individual or entity named on this transmission. 
If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution or taking of any 
action in reliance on the contents of this emailed information is strictly prohibited, and that the documents should be returned to Fusion-io, Inc. immediately. 
In this regard, if you have received this email in error, please notify us by return email immediately.
