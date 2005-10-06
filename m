Return-Path: <nreddy@netenrich.com>
Received: from mail.netenrich.com (unknown [204.13.82.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F9A368387
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Oct 2005 19:24:53 +1000 (EST)
Message-ID: <54964.61.95.208.3.1128590223.squirrel@61.95.208.3>
Date: Thu, 6 Oct 2005 02:17:03 -0700 (PDT)
From: nreddy@netenrich.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: u-boot-users@lists.sourceforge.net
Subject: " Problem in copying files into /mnt/jffs2 directory "
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am working on PPC405ep (walnut board) board which has 4MB AMD flash and
working fine .
Recently we have increased FLASH size to 8MB and modified Flash drivers
accordingly.
I have taken some help from uboot users.
Thanks for giving such kind of invaluable help.

Now the system is up and running well, but i get into some other problem
like when copying files to /mnt/jffs2 directory it is taking so much extra
time to copy files.
But when i was using 4MB flash it was taking 1/4 of this time.

Can some one throw a lite on this.

Thanks & Regards,
--Nagi
