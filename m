Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 0E11B67E75
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 15:40:17 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so83773wri
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 02 Aug 2005 22:40:16 -0700 (PDT)
Message-ID: <9b7ca6570508022240715ae9cb@mail.gmail.com>
Date: Wed, 3 Aug 2005 14:40:16 +0900
From: Daniel Ann <ktdann@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: MPC8245 reboot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hey folks,

I have a problem with rebooting my box(its pretty much based on sandpoint).
Looking at sandpoint_restart() function, I have no idea what it's
doing. Can somebody please help me out where I should be looking ?
Would this be pure software problem? or just might be hardware problem
?

Always thought rebooting was piece of cake, but.. guess not :P
--=20
Daniel
