Return-Path: <littelld@verizon.net>
Received: from vms173003pub.verizon.net (vms173003pub.verizon.net
	[206.46.173.3]) by ozlabs.org (Postfix) with ESMTP id 8E050DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Jul 2008 11:43:13 +1000 (EST)
Received: from [192.168.1.106] ([71.170.110.166]) by vms173003.mailsrvcs.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTPA id <0K3E005CINB3J009@vms173003.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Wed, 02 Jul 2008 19:42:39 -0500 (CDT)
Date: Wed, 02 Jul 2008 19:42:38 -0500
From: Dave Littell <littelld@verizon.net>
Subject: Changing zImage load and entry point address?
To: linuxppc-embedded@ozlabs.org
Message-id: <486C207E.6080302@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
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

For a 2.6.18-based zImage, how do I change the load and the entry point
addresses to something other than the default 0x800000?  Changing the
.config (CONFIG_BOOT_LOAD_BOOL and CONFIG_BOOT_LOAD) seems to accomplish
nothing...


Thanks,
Dave
