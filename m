Message-ID: <3DC8B923.8030203@pop.agri.ch>
Date: Wed, 06 Nov 2002 07:39:31 +0100
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: Stefan Jeglinski <jeglin@4pi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Sonnet G4 800 in 1st gen PCI mac + linux ...
References: <p05100300b9ebaedd46a7@[192.168.0.8]>
In-Reply-To: <p05100300b9ebaedd46a7@[192.168.0.8]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Stefan Jeglinski wrote:

> With 2.4.20-pre9-ben0, I note the following things:
>
> 1. Although cpuinfo still shows 'l2cr override : 0x80000000', there is
>     not dmesg line stating that the cache is enabled.


[andreas@wallstreet andreas]$ cat /proc/sys/kernel/l2cr
0xb9000000:  enabled, no parity, 1MB, +2 clock, pipelined burst SRAM,
copy-back, 0.5ns hold

On a 2.4.20-pre11-ben0.

Is this proc entry available on your system?

Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
