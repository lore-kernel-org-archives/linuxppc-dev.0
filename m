Return-Path: <mlcreech@gmail.com>
Received: from mail-qy0-f193.google.com (mail-qy0-f193.google.com
	[209.85.221.193]) by ozlabs.org (Postfix) with ESMTP id F3190B7088
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 08:27:24 +1000 (EST)
Received: by qyk31 with SMTP id 31so2259609qyk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Sep 2009 15:27:22 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 21 Sep 2009 18:27:22 -0400
Message-ID: <5ee96a840909211527g45b47b3fgff907df69fe48666@mail.gmail.com>
Subject: NAND partition names in DTS must be named "partition"?
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I upgraded from 2.6.29 to 2.6.31, and the kernel no longer recognized
the partitions embedded within my DTS file.  I had to revert this
change:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4b08e149c0e02e97ec49c2a31d14a0d3a02f8074

in order to boot.  This code looks like it expects all partitions to
be named "partition", otherwise they're just skipped.  Is there some
peculiarity in my setup that makes this not work, or is it a general
problem?  I see no major differences between my DTS file and the
stardard "mpc8313erdb.dts".

Thanks

-- 
Matthew L. Creech
