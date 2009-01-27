Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 682CDDE054
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 01:58:37 +1100 (EST)
Message-Id: <0D5BDAF5-E5FD-42FC-977C-B83664FE4C78@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: tglx@linutronix.de, mingo@elte.hu
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: sharing an interrupt between a cascaded/chained pic and another device
Date: Tue, 27 Jan 2009 08:57:54 -0600
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-kernel Kernel <linux-kernel@vger.kernel.org>,
	Peters Ted <Ted.Peters@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thomas, Ingo,

Do we have any support in the kernel today to deal with a IRQ on the  
root PIC being used for both a chained PIC and shared with another HW  
device.  We have a board that guys went and did it and as I look at  
the kernel code it doesn't seem like this crazy situation is currently  
supported.

- k
