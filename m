Return-Path: <mk@creamnet.de>
Received: from mail.uni-ulm.de (mail.uni-ulm.de [134.60.1.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A9D7679EB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 04:46:10 +1000 (EST)
Received: from localhost (hms1126.wh-hms.uni-ulm.de [134.60.221.126])
	(authenticated bits=0)
	by mail.uni-ulm.de (8.13.3/8.13.3) with ESMTP id j49IPvdQ006433
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 9 May 2005 20:25:59 +0200 (MEST)
Date: Mon, 9 May 2005 20:27:47 +0200
From: Markus Klotzbuecher <mk@creamnet.de>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050509182747.GA27743@mary>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [ANNOUNCE] mini_fo-0.6.0 overlay file system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

mini_fo is a virtual kernel filesystem that can make read-only file
systems writable. This is done by redirecting modifying operations to
a writeable location called "storage directory", and leaving the
original data in the "base directory" untouched. When reading, the
file system merges the modifed and original data so that only the
newest versions will appear. This occurs transparently to the user,
who can access the data like on any other read-write file system.

mini_fo was originally developed for use in embedded systems, and
therefore is lightweight in terms of module size (~50K), memory usage
and storage usage. Nevertheless it has proved usefull for other
projects such as live cds or for sandboxing and testing.

For more information and download of the sources visit the project
page:

http://www.denx.de/twiki/bin/view/Know/MiniFOHome

ChangeLog for mini_fo-0-6-0:
   - support for 2.4 and 2.6 kernels.
   - mini_fo now implements all file system operations.
   - many bugfixes and code cleanup.


Markus Klotzbuecher
