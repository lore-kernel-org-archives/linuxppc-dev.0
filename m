Message-Id: <383A0E2E.9A261E81@ict.ac.cn>
Date: Tue, 23 Nov 1999 11:46:54 +0800
From: LiuTao <tliu@ict.ac.cn>
Mime-Version: 1.0
To: Dan Malek <dmalek@jlc.net>
Cc: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: need suggestions
References: <3839F122.3BF6FEDF@ict.ac.cn> <383A0E2D.CFACF894@jlc.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Dan:

Thanks for your advice.
The bootloader that I am using with vxWorks uses FTP but not TFTP.
And I don't have the source code of that bootloader. I think there
are maybe some problems to use it download and boot linux. So I hope
to find a TFTP source code and program a bootloader by myself.
Of course, if anybody has a presented bootloader source code,
that's great.

LiuTao

Dan Malek wrote:
> 
> LiuTao wrote:
> 
> > ........ The board
> > is running well with vxWorks now.
> > I want to make a bootloader on the board.
> 
> How do you load vxWorks?  I have worked on several vxWorks projects,
> and all of the systems had the vxWorks TFTP loader in the rom.  Use
> the same thing (whatever that is) to load the Linux/PPC image.
> 
> The zImage is linked such that you can just treat it as a bag o' bits
> to dump into memory.  Even with non-standard boot loaders, all you
> need to do is write a simple program to strip the 64K ELF header, place
> your own header on the top, make sure it gets loaded above 0x180000
> and jump to the start of the image.
> 
>         -- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
