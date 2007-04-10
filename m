Return-Path: <powerpc440@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 5081DDDF18
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 00:50:30 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so77705ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 07:50:28 -0700 (PDT)
Message-ID: <461BA458.2010605@googlemail.com>
Date: Tue, 10 Apr 2007 16:51:04 +0200
From: powerpc440 <powerpc440@googlemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Multiple Boards with same MAC addresses - problem.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all,

I have multiple boards, based on ppc405ep (which include on-chip two
ethernet ports). I'm configure the MAC address in u-boot and all works
great. The problem appears when I use two or more boards in one network,
because the MAC addresses are the same. Now I'm making a own u-boots for
each board, but this solution is not very comfortable.
My question is, which is the standard way to resolve such problem? I
would have only one generic u-boot. Is this possible?


Best regards,

Zhivko Yordanov
