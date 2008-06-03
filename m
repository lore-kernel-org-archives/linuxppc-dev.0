Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 525ADDE3AA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 19:13:35 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m539DUDq009752
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 11:13:30 +0200
Message-ID: <078101c8c55a$16c70790$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
References: <24952919.541821212479475605.JavaMail.coremail@bj163app79.163.com>
Subject: Re: problems with porting linux 2.6 kernel to xupv2p
Date: Tue, 3 Jun 2008 11:13:24 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="GB2312"; reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Have you tried compiling the Xilinx git tree ? I'm now using it fine with an 
ML405 board and I've seen options for xup in it:
git clone git://git.xilinx.com/linux-2.6-xlnx.git-- 
Guillaume Dargaud
http://www.gdargaud.net/
