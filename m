Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id 47BF567B26
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 17:29:10 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF76EEFE38.5001E643-ONC125701B.00283639@brime.fr>
From: scarayol@assystembrime.com
Date: Thu, 9 Jun 2005 09:30:43 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: Read in /dev/port with Segmentation Fault
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I want to access to IO ports on a MPC885. The iopl() is not implemented, in
my distribution, to use inw() outw().
So I use /dev/port. It works for open("/dev/port",..) and lseek() but when
i do a read()  i have a segmentation fault. I gave all the right to
/dev/port
Does anybody have an idea ?
Thanks a lot.

Sophie CARAYOL
