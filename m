Message-ID: <403343E6.7090200@jonmasters.org>
Date: Wed, 18 Feb 2004 10:52:22 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Jon Masters <jonathan@jonmasters.org>
Cc: Mike Wellington <wellington@lucent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ml300 boot loader question
References: <20040211214947.87373.qmail@web21110.mail.yahoo.com> <402CEC30.9060503@xilinx.com> <402E2841.9020700@jonmasters.org> <402EA47B.2010600@lucent.com> <402F524C.3020009@jonmasters.org>
In-Reply-To: <402F524C.3020009@jonmasters.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

The breakage is happening inside an mmap call when using dynamically
linked binaries and only when not tracing the process running.

Offset in r8 is broken and I am not sure yet whether this is purely a
hardware corruption of the kernel stack or a subtle kernel bug.

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
