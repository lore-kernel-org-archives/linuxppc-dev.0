Message-Id: <5.0.2.1.0.20010508085652.00a4aec0@pop.gmx.de>
Date: Tue, 08 May 2001 08:58:16 +0800
To: "machael thailer" <dony.he@huawei.com>
From: Michael Habermann <MHabermann@gmx.de>
Subject: Re: Uncompress Ok, but cannot run linux kernel...
Cc: <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <001d01c0d5c8$27ae8c60$8021690a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 09:01 AM 5/6/2001 +0800, machael thailer wrote:


>     I have a 750-based custom board. I want to port linux-2.4.2 on it. The
>bootrom code which initialized the hardware is working OK. I want to
>download the linux kernel via TFTP(and it is OK now) and run it. But I met
>some urgent problems ...

I have the same problem on an FADS board. Tracing head.S showed me that the
code returns with
a return from interrupt instead of a branch. So it maybe works if the image
is used without bootloader or by changing head.S.

I'll test it today, please let me know if you've found the problem.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
