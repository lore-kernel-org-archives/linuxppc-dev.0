Message-ID: <3F79D118.9040208@il.marvell.com>
Date: Tue, 30 Sep 2003 21:53:12 +0300
From: Rabeeh Khoury <rabeeh@il.marvell.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org,
	ppcboot-users@lists.sourceforge.net
Subject: Operating system question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

I have a question withregards WIMG MMU settings of page tables / BATs.
Is there any reason why setting the M bit (coherency) on an IO
region (cache inhibited and guarded) ?
Does anyone expect what is the result of doing so ?

I'v seen in the Linux code for PPC that on IO region the M bit is never
set - but what about firmwares ? other operating system ?

Thank you,
Rabeeh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
