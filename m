Return-Path: <bgat@billgatliff.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id C52EBB7D41
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Apr 2010 13:05:46 +1000 (EST)
Received: by gyf2 with SMTP id 2so459146gyf.15
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Apr 2010 20:05:44 -0700 (PDT)
Message-ID: <4BC682DC.1050200@billgatliff.com>
Date: Wed, 14 Apr 2010 22:07:08 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>, agust@denx.de
Subject: Xorg on Fujitsu "Lime" with MPC5200b?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guys:


I'm not quite sure where to ask this question, but all my attempts
elsewhere have come up short, so...

Put simply, I have an MPC5200b platform with a Fujitsu "Lime" GDC, and
I'm trying to run Debian squeeze's xorg on it.

Actually, I *have* Debian squeeze's xorg running on the platform just
fine, with a 2.6.34-rc1 kernel (kernel.org).  Problem is, every single
diagonal line is very blocky--- not smooth at all.  I used to think this
was a problem with X's fonts, but now I don't think so because the mouse
cursor's diagonal lines also look equally bad.

It's almost as if any time the platform tries to draw a diagonal line,
truncation/rounding errors are causing it problems in figuring out which
pixels to turn on and off.

A non-Linux kernel on this hardware, running a non-X GUI, seems to work
fine so I think the hardware isn't the problem.

Anyone have any suggestions on where to start with this one?  Anyone
else running a similar configuration with any success?  I'm completely
lost, and running out of hair *fast*...


Thanks!


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
