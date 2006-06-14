Return-Path: <antonio.dibacco@aruba.it>
Received: from mx1.aruba.it (mxaruba.aruba.it [62.149.128.10])
	by ozlabs.org (Postfix) with SMTP id B80D767B74
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 18:28:40 +1000 (EST)
Message-ID: <20060614082832.14389.qmail@mx1.aruba.it>
From: "antonio.dibacco" <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: SMC2 uart problem when using SCC3 as hdlc
Date: Wed, 14 Jun 2006 08:28:32 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I use an MPC880, SMC1 as uart, SMC2 as uart, SCC3 as HDLC are used. When I 
compile support for SCC3 hdlc in the kernel, the SMC2 stops working. It 
hangs, sometime kernel reboots.

Any relocation patch should be used?
As far as I know should not be needed! 

Bye,
Antonio.
