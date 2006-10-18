Return-Path: <boris@fabiotec.com>
Received: from mtaout4.barak.net.il (mtaout4.barak.net.il [212.150.49.174])
	by ozlabs.org (Postfix) with ESMTP id 702F367B6D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 07:10:34 +1000 (EST)
Received: from [192.168.200.97] ([62.90.35.117])
	by mtaout4.barak.net.il (Sun Java System Messaging Server 6.2-6.02
	(built Apr
	25 2006)) with ESMTPA id <0J7C00HWWMRJK7E0@mtaout4.barak.net.il> for
	linuxppc-embedded@ozlabs.org; Wed, 18 Oct 2006 22:40:31 +0200 (IST)
Date: Wed, 18 Oct 2006 22:40:31 +0200
From: Boris Shteinbock <boris@fabiotec.com>
Subject: CPM2 (MPC8260) SMC problem. Please help.
To: linuxppc-embedded@ozlabs.org
Message-id: <4536913F.8060801@fabiotec.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi ppl.

I have discovered very very odd problem with SMC2 on my 8260 board.
kernel version is 2.6.17.

The board is 8260 with serial ports on SMC1 and SMC 2 (SMC1 - console)

Now if I use SMC2 for communicating with remote device, ( some protocol)
I am sending packets and wait for a response.
However if the packet I send is SMALLER than 5 bytes, SMC goes 
completely crazy.
write() doesn't return error, but the next read() hangs completely, and the
process moves to D state and it is impossible to kill it by any means.
It only happens when consequent writes of smaller than 5 bytes.
I tried to check the driver, but couldn't find any clues to what goes wrong.

I tried both compatibility and platform-based modes with the same results.

Any help on the issue would be highliy appreciated.
