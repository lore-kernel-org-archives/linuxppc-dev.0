Message-ID: <38DFC2EF.9F3BB501@embeddededge.com>
Date: Mon, 27 Mar 2000 15:22:07 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Tom Miles <tmiles@teltronics.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Swap space on Embedded Planet CLLF 860
References: <7143C7BA3BFAD2119AAC0008C7094B9965043A@postoffice2.teltronics.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Miles wrote:
>
> I have my CLLF 860 coming up via TFTP boot with a NFS mounted root file
> system.  The kernel crashes after a short while always in relation to a page
> swap.

What kernel are you running and what patches did you apply?  This
happens when you screw up a PTE, and some of the MMU patches floating
around can cause this.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
