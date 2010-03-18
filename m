Return-Path: <wilbur512@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 55EE9B7D1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 04:39:30 +1100 (EST)
Received: by gyf1 with SMTP id 1so1208620gyf.15
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Mar 2010 10:39:29 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 19 Mar 2010 01:39:28 +0800
Message-ID: <e997b7421003181039t6e88dc5cu921594ae3814c26a@mail.gmail.com>
Subject: Does ppc cpio have limit in size?
From: "wilbur.chan" <wilbur512@gmail.com>
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

Recently I 'm using cpio filesystem (kernel and filesystem compressed
as a whole) on ppc8270 .

However I found that the bigger the size of uImage is , the easier
kernel failed when booting.

Everytime it failed when calling "populate_rootfs"  when booting, so I
guess maybe the size of uImage effect booting procedure.


Anyone know how to boot a large cpio uImage ?  Thank you!

regards,

wilbur
