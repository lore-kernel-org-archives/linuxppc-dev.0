Return-Path: <Hans.Schillstrom@lgpallgon.com>
Received: from aseit003.allgon.net (mail.lgpallgon.com [193.235.198.4])
	by ozlabs.org (Postfix) with ESMTP id 67C742BF23
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 02:25:54 +1100 (EST)
From: Hans Schillstrom <hans.schillstrom@pwav.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Message-Id: <1105541751.7900.249.camel@hawk.allgon.net>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 15:55:51 +0100
Subject: mpc8270vr
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
Is there any one that have a mpc8270vr (rev 0.01 1k49M mask) running
a 2.6 kernel ?

I have a couple of boards with mpc8250vr and mpc8270vr (the board is
identical for the processor).
The kernel image is the same, the 8250 works fine.
The 8270 hangs when creating the init thread:
  kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);

Any one that have an idea ?

Regards 
/Hans
