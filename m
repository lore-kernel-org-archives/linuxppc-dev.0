Return-Path: <zhonglei@RCS-9000.COM>
Received: from RCS-9000.COM (unknown [218.94.131.104])
	by ozlabs.org (Postfix) with ESMTP id 8FDE5683CE
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Sep 2005 10:56:43 +1000 (EST)
Date: Tue, 27 Sep 2005 08:59:45 +0800
Message-Id: <200509270859.AA76218526@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
To: <linuxppc-dev@ozlabs.org>
Subject: share memory
Reply-To: zhonglei@RCS-9000.COM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi:
  I want my driver to transfer 512byte data from kernel to user-space every 100us in the interrupt routine. Because the amount of data is  large, the copy_to_user(...) is too slow to fit the request.I tried to use sys_shmat in my driver to build a share memory,but the return of the function is a kernel virtual address which I can not use in the kernel interrupt routine directory! 
  What can I do? What function can I use to convert the kernel virtual address to kernel logic address? Or is there some other good way to handle this problem?
  Thanks a lot!
zhonglei
