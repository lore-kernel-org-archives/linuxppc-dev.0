From: ghannon@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256DE4.004F812B.00@pine.cspi.com>
Date: Thu, 20 Nov 2003 09:36:30 -0500
Subject: MTD and Intel rev J Strata Flash
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm assuming the linux-mtd list has long since vanished.

I'm working with a rev J strata flash part.

It has the "feature" that it's lock-bits can be set individually,
but are cleared colllectively.    I have made a 3 partition system
where I mainly want two partitions locked except when I am updating
them, and the third one unlocked always.

Has any effort  been put into the MTD layer to take into account that
an unlock clears all the bits and some should be put back on.
I didn't see anything like that in the code.

I will put the functionality into my tools if it is not in a lower layer
already.

Thanks,

Gary Hannon
CSPI


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
