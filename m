From: ghannon@cspi.com
To: jwalden@digitalatlantic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256D17.0055A864.00@pine.cspi.com>
Date: Tue, 29 Apr 2003 11:41:24 -0400
Subject: Re: get program exception in early setup
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jerry Walden wrote:

> From System.map:

> c0113000 A __bss_start
>     |
>     |
>     |
>     V
> c013c050 A _end

> The symbol _end does not come after the bss - it is at the end of the
> kernel, so the memset gets an exception.

_end is correctly after bss_start.

There is probably a different problem with how memory is mapped.

Did your kernel get decompressed correctly at 0?


Gary


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
