Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id 6DC1568461
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Oct 2005 19:39:19 +1000 (EST)
To: nreddy@netenrich.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 06 Oct 2005 02:17:03 PDT."
	<54964.61.95.208.3.1128590223.squirrel@61.95.208.3>
Date: Thu, 06 Oct 2005 11:38:50 +0200
Sender: wd@denx.de
Message-Id: <20051006093850.B6B79353A0B@atlas.denx.de>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject: Re: [U-Boot-Users] " Problem in copying files into /mnt/jffs2
	directory "
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <54964.61.95.208.3.1128590223.squirrel@61.95.208.3> you wrote:
> 
> Now the system is up and running well, but i get into some other problem
> like when copying files to /mnt/jffs2 directory it is taking so much extra
> time to copy files.
> But when i was using 4MB flash it was taking 1/4 of this time.

This is off topic *both* on the U-Boot and on  the  linuxppc-embedded
mailing  lists. The MTD mailing list would be a much better place for
such questions (linux-mtd@lists.infradead.org).  But  before  posting
ther  make  sure  to  include  some detail about your system: type of
flash chips used, which versionof the MTD / JFFS2 driver code,  which
exact  kernel  version.  And  make  sure  to read the instructions at
http://www.linux-mtd.infradead.org/mail.html, especially the  section
about kernel versions
http://www.linux-mtd.infradead.org/source.html#kernelversions

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Nothing ever becomes real until it is experienced.       - John Keats
