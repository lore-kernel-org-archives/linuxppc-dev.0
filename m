Message-ID: <3DA1A08B.3C71949D@selta.it>
Date: Mon, 07 Oct 2002 13:56:11 -0100
From: stefania magistrali <s.magistrali@selta.it>
MIME-Version: 1.0
To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot linux on fads mpc860
References: <20021007112640.38961.qmail@web8005.mail.in.yahoo.com>
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You have to download the FADS image. You have to create an image like this:
mkimage -n 'Linux FADS image' -A ppc -O linux -T kernel -C gzip -a 00000000 -e
00000000  -d $(PATH_TO_VMLINUX)/vmlinux.gz fads-image
where mkimage is created as a tool in ppcboot
Then you can use tftpboot to download it (es. tftpboot 100000 fads-image)
Bye!
Stefania

rekha gvv wrote:

> Hello,
> I am new to this mailing list.
> I am trying to boot linux from Fads MPC860 powerpc
> board I have compiled the linux kernelversion
> linux-2.4.4-2002-03-21 .Also i have put the PPcboot
> 1.1.6 into the board.now i dont know how to download
> this linux kernel into this board.Should i do any
> sttings with ppcboot .please do let me know
> i am using the tftpboot command but then
> wheni tell go 100000 it tells
>
> ## starting application at 0x00100000
>
> thenit hangs ..
> i have tried to download the vmlinux file also
> converted that to binary format and also tried but it
> gives the same problem
> one more thing is when i used the BOOTM command
> it used to give
>
> ##Booting application at 0x00100000
> Bad magic number
>
> I dont understand what to do.so kindly please help
> Regards
> Rekha
> rekhagvvc@yahoo.co.in
>
> Faith Hill - Exclusive Performances, Videos & More
> http://faith.yahoo.com
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
