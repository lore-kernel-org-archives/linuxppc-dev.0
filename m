Return-Path: <sheutlin@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 35962DDE43
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 07:44:12 +1100 (EST)
Message-ID: <45CCDD16.1020807@gmx.de>
Date: Fri, 09 Feb 2007 21:44:06 +0100
From: Sebastian Heutling <sheutlin@gmx.de>
MIME-Version: 1.0
To: Bob Brose <linuxppcdev@qbjnet.com>
Subject: Re: 2.6.20 zImage.prep??
References: <20070209180755.26640.qmail@kunk.qbjnet.com>
In-Reply-To: <20070209180755.26640.qmail@kunk.qbjnet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I can only tell you that it works for 2.6.18 using the debian linux 
image package. But you need to install linux-image-2.6.18-prep instead 
of linux-image-2.6.18-powerpc.


Sebastian


Bob Brose wrote:
> Is PReP currently suported? The last kernel version I could make a
> zImage.prep in was 2.6.14. I see some references to PReP and new
> kernels here but nothing I'd call definitive.
>
> >From digging around the net it looks like one is supposed to use
> mkvmlinuz to do this now however:
>
> 1) The utilities mkprep, mktree and mkbugboot aren't build be default
> in 2.6.20 from what I can see and
>
> 2) Even when I build them and try mkvmlinuz there are errors:
> debian:/usr/src/linux# mkvmlinuz -v -o vmlinuz.prep -a prep -k vmlinux -r 2.4.20
> === Building for sub-architecture prep.
> === Using kernel image file vmlinux.
> === Release version seems to be 2.4.20.
> === Using object files from /usr/src/linux.
> === Building a bootable compressed kernel image in vmlinuz.prep.
> === Doing build in /tmp/tmp.kTUDZ23437.
> === Creating compressed kernel image vmlinux.gz...
> objcopy -O binary vmlinux /tmp/tmp.kTUDZ23437/vmlinux
> gzip /tmp/tmp.kTUDZ23437/vmlinux
> === Putting everything into ELF image file image.o...
> objcopy -R .comment /tmp/tmp.kTUDZ23437/image.o
> objcopy: '/tmp/tmp.kTUDZ23437/image.o': No such file
> objcopy: error: the input file '/tmp/tmp.kTUDZ23437/image.o' is empty
> objcopy /tmp/tmp.kTUDZ23437/image.o /tmp/tmp.kTUDZ23437/image.o --add-section=.image=/tmp/tmp.kTUDZ23437/vmlinux.gz --set-section-flags=.image=contents,alloc,load,readonly,data
> objcopy: '/tmp/tmp.kTUDZ23437/image.o': No such file
> objcopy: error: the input file '/tmp/tmp.kTUDZ23437/image.o' is empty
> === Creating bootable kernel image file vmlinuz.prep...
> Sorry, I do not know how to handle PowerPC sub-architecture prep in version 2.4.20.
>
> This is debian sid. If I try the mkvmlinuz command for chrp it works fine.
>
> Regards,
> Bob
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   
