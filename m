Return-Path: <shawnxjin@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.203])
	by ozlabs.org (Postfix) with ESMTP id 04C98682B2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 10:07:15 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id l1so432623nzf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 17:07:14 -0700 (PDT)
Message-ID: <c3d0340b050915170043abba5f@mail.gmail.com>
Date: Thu, 15 Sep 2005 17:00:06 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: How to dump D-cache
Reply-To: shawnxjin@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

The instruction dcread is used to read data cache. The syntax is
dcread RT,RA,RB. The effective address is formed by adding RA to RB.
In order to read a specific cache line or the whole d-cache, how do I
know the effective addresses correponding to the cache line(s)? The
processor is ppc440.

Thanks,
-Shawn.
