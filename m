Message-ID: <39C7A03A.93075582@mvista.com>
Date: Tue, 19 Sep 2000 13:19:54 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Prashant Patel <pmpatel@trinetcommunication.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4MB DRAM is enough for linux kernel 2.2.13
References: <002101c0225b$976c4f40$4d1f76d8@kennedy>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Prashant Patel wrote:
>
> Hello Everybody
>         Can someone tell me if 4MB DRAM is enough to boot linux kernel
> 2.2.13. Note that the 8xx rom boot loader occupies around 500k.

Yes, I can say it will not work.

The code in the arch/ppc/mbxboot directory, which is used for
all 8xx and 8260 processors, assumes there is memory above 4 MB
it can use for buffer space while decompressing the kernel.  You
can play around with adjusting these addresses and sizes, and get
a kernel to boot.  You will get a shell prompt, and that is about
all.  You won't be able to use a ramdisk, you probably won't be
able to execute any useful programs.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
