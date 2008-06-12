Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83508.mail.sp1.yahoo.com (web83508.mail.sp1.yahoo.com
	[216.252.120.164]) by ozlabs.org (Postfix) with SMTP id 593B0DE208
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 05:35:47 +1000 (EST)
Date: Thu, 12 Jun 2008 12:35:45 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Using DMA interrupt on MPC8313
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <937773.70026.qm@web83508.mail.sp1.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to write a driver that would make use of the DMA on the MPC8313.  I'm attempting to
register the interrupt with request_irq but it is not passing.  Is there something that I need to
do before I call request_irq, maybe in the dts or somewhere else?

Ron
