Return-Path: <zhonglei@RCS-9000.COM>
Received: from RCS-9000.COM (unknown [218.94.131.104])
	by ozlabs.org (Postfix) with ESMTP id 809D1680A5
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 17:23:28 +1000 (EST)
Date: Wed, 24 Aug 2005 15:11:11 +0800
Message-Id: <200508241511.AA32243824@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
To: <linuxppc-dev@ozlabs.org.>
Subject: unresolved symbol
Reply-To: zhonglei@RCS-9000.COM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

hi 
   My mod has no error or warning during compiling.But when I "insmod hello.o" , it shows:
   hello.o : unresolved symbol TaskStart
   hello.o : unresolved symbol TasksLoadImage
   hello.o : unresolved symbol TasksInitAPI
   ...
What's the problem?
BestRegards
zhonglei
