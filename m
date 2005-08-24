Return-Path: <zhonglei@RCS-9000.COM>
Received: from RCS-9000.COM (unknown [218.94.131.104])
	by ozlabs.org (Postfix) with ESMTP id 28D76680D8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 17:05:06 +1000 (EST)
Date: Wed, 24 Aug 2005 15:07:58 +0800
Message-Id: <200508241507.AA31981680@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
To: <linuxppc-embedded@ozlabs.org.>
Subject: unresolved symbol
Reply-To: zhonglei@RCS-9000.COM
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi
   My mod has no error or warning during compiling.But when I "insmod hello.o" , it shows:
   hello.o : unresolved symbol TaskStart
   hello.o : unresolved symbol TaskLoadImage
   hello.o : unresolved symbol TaskInitAPI
   ...
What's the problem?
BestRegards
zhonglei
