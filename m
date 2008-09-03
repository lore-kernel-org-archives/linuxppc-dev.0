Return-Path: <littelld@verizon.net>
Received: from vms042pub.verizon.net (vms042pub.verizon.net [206.46.252.42])
	by ozlabs.org (Postfix) with ESMTP id A61F6DDEFB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Sep 2008 10:35:30 +1000 (EST)
Received: from [192.168.1.106] ([96.226.142.190])
	by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01
	(built Apr
	3 2006)) with ESMTPA id <0K6N00D8H86QZI5A@vms042.mailsrvcs.net> for
	linuxppc-embedded@ozlabs.org; Wed, 03 Sep 2008 18:35:14 -0500 (CDT)
Date: Wed, 03 Sep 2008 18:35:14 -0500
From: Dave Littell <littelld@verizon.net>
Subject: direct access to Flash from userland
To: linuxppc-embedded@ozlabs.org
Message-id: <48BF1F32.8010707@verizon.net>
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

I have a CFI Flash device which has some non-CFI commands I need to
issue from userland.  I've tried mmap() of the mtdblock device, but that
only yielded a corrupted Flash as my non-CFI command sequences were
simply written to Flash.  An attempted mmap() of the character mtd
device fails the mmap() call.

Is there a way for a userland application to issue non-CFI commands
directly to a Flash device?  (This is a 2.6.18-based kernel on a AMCC
PPC440EPx platform.)


Thanks,
Dave
