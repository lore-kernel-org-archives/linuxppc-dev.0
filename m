Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id 06C3667EB8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Aug 2005 07:38:44 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i11so715677wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 14:38:40 -0700 (PDT)
Message-ID: <c3d0340b0508121438fe0fbe4@mail.gmail.com>
Date: Fri, 12 Aug 2005 14:38:40 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <c3d0340b05081214282adeda4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b050811154148164691@mail.gmail.com>
	<20050811231454.GA5796@gate.ebshome.net>
	<20050811231710.GB5796@gate.ebshome.net>
	<c3d0340b05081214282adeda4c@mail.gmail.com>
Subject: Re: What's wrong with the serial port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Has the serial port enabled interrupt so far at this stage?

Don't bother. I found the answer. console_init() is before
local_irq_enable(). So no interrupt is enabled before
local_irq_enable().

-Shawn.
