Message-ID: <3981D46D.1CBEFF74@embeddededge.com>
Date: Fri, 28 Jul 2000 14:43:57 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Paolo Scaffardi <arsenio@tin.it>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC8xx-2.2.13 kernel and Framebuffer support: cannot compile!
References: <001b01bff7e1$ab6b4720$640a0a0a@server>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paolo Scaffardi wrote:
>
> I trying to develop a simple framebuffer driver for my MPC823FADS Video
> analog output, but when i modify the kernel to include the any frame buffer
> device driver, the compilers reports me:

Go visit www.mvista.com.  We already have 823 frame buffers for
some products in the Linux kernels.  It would at least be a starting
point for your customization.

> I cannot use other kernels because of my FADS board (not supported by
> HardHat and similars).

It may be easier to add FADS support to a kernel that already supports
the frame buffer.  Unfortunately, I am adding FADS support (again) to
the Linux kernel, and I guess I will make it stick this time.......


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
