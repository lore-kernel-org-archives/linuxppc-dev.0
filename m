Message-ID: <39405BFB.1E231721@embeddededge.com>
Date: Thu, 08 Jun 2000 22:52:43 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Murray Jensen <Murray.Jensen@cmst.csiro.au>
CC: Daniel Wu <Daniel.Wu@alcatel.com.au>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using zImage.initrd
References: <27066.960518430@msa.cmst.csiro.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Murray Jensen wrote:

> Try this patch:
>
> --- fs/buffer.c 2000/05/16 01:31:41     1.1.1.12


The 2.2.xx kernels don't have any ramdisk patch required.  This was
broken in later 2.3.xx kernels.  Don't be trying this in 2.2 kernels.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
