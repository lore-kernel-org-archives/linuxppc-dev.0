Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F140928.60403@imc-berlin.de>
Date: Tue, 15 Jul 2003 16:01:12 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DENX ELDK Kernel
References: <20030715135119.5782CC6D82@atlas.denx.de>
In-Reply-To: <20030715135119.5782CC6D82@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>>never stopped me before!  Basically, the answer is yes - at least I
>>have been using the ELDK with a linux-2.4.20 kernel (from kernel.org).
>>The key point to remember is that you should always compile user
>>applications against the Linux include files that glibc (and all the
>>rest of the target ELDK apps) are built against - Do NOT compile your
>>user applications against the newer Linux kernel.
>
>
> 10 of 10 points :-)

Stupid question (TM):

If I'd built the ELDK from scratch and used Linux-2.4.20 include files
to build "glibc (and all the rest of the target ELDK apps)" I should
build my "applications against the newer Linux kernel"! Shouldn't I?

And in general: shouldn't I used a glibc that "matches" the kernel
version?

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
