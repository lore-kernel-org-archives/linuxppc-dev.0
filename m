Message-ID: <39EFA8CE.33485BAD@mvista.com>
Date: Thu, 19 Oct 2000 22:07:10 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: brendan.simon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linux-embedded: smallest kernel for 2.4.0-test9
References: <39EF7A07.5D946387@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan J Simon wrote:

> ....  I currently have the kernel down to 520K
> but would like to get it under 448K (512K minus one 64K sector for a
> bootloader).  Is this possible ???


Heh...I did this just the other day with a old -test2 kernel.

Did you remove the ELF header?

	dd if=zImage bs=64k skip=1 of=zImage.bin

The starting instruction is the first word of zImage.bin.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
