Message-ID: <3E32D0DD.5050805@embeddededge.com>
Date: Sat, 25 Jan 2003 13:01:01 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Omanakuttan <omanakuttan@tataelxsi.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel hangs in copy_and_flush while `lwzx` instruction
References: <3E32B782.9060603@tataelxsi.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Omanakuttan wrote:

> kernel hangs while executing the following lines in arch/ppc/kernel/head.S.

You shouldn't be executing that code at all for this board/processor combination.
The conditions that get you into this indicate the kernel isn't built or
loaded properly.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
