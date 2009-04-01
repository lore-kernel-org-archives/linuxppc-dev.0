Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83502.mail.sp1.yahoo.com (web83502.mail.sp1.yahoo.com
	[216.252.120.158]) by ozlabs.org (Postfix) with SMTP id 99B41DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 04:24:57 +1100 (EST)
Message-ID: <722080.36173.qm@web83502.mail.sp1.yahoo.com>
Date: Wed, 1 Apr 2009 10:24:54 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: USB drivers
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: ron_madrid@sbcglobal.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I have a custom board based on the MPC8313ERDB and have communications
capabilities over Ethernet using internet sockets.  Basically, just data
transfer from the host (my board) to a client (a PC).  I want to be able to
perform similar transactions across USB.

I have done some cursory reading but am a little unclear on how I should
approach this.  Am I going to have to write a host driver for my custom
board, and also write a gadget driver for any client machine?  Also, since I
am desiring to do simple data transfers only, which drivers could I use as a
point of reference for my application?

Thanks in advance for any tips and suggestions.

Ron
