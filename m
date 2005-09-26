Return-Path: <zhonglei@RCS-9000.COM>
Received: from RCS-9000.COM (unknown [218.94.131.104])
	by ozlabs.org (Postfix) with ESMTP id 6E34568336
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Sep 2005 17:45:07 +1000 (EST)
Date: Mon, 26 Sep 2005 15:48:03 +0800
Message-Id: <200509261548.AA26280018@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
To: <linuxppc-dev@ozlabs.org>
Subject: sys_shmat
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
   I get a pointer shramptr from sys_shmat(shid,0,SHM_R|SHM_W,&shramptr) to use share RAM in my driver.
But when I assign a value into this pointer in my interrupt routine,
the system shows: oops: kernel access of bad area!
what's the problem?
thanks
zhonglei 
