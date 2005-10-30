Return-Path: <wartan.hachaturow@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id 492886862F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 00:59:45 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i23so398314wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Oct 2005 05:59:44 -0800 (PST)
Message-ID: <4aaa2e1c0510300552q604f0757o6916a4e4fd6ec785@mail.gmail.com>
Date: Sun, 30 Oct 2005 16:52:40 +0300
From: Wartan Hachaturow <wartan.hachaturow@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: fcc_enet multicast support.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

For quite some time set_multicast_list() is commented out in fcc_enet.c,
because it is said to be broken.
What were particular reasons to do that, i.e., where exactly is it broken?

P.S. I've seen this question in archives, but it hasn't been answered back =
then,
so I thought it's time to pose it again :)

--
Regards, Wartan.
