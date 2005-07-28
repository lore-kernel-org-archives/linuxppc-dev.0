Return-Path: <frannk_m1@yahoo.com>
Received: from web32203.mail.mud.yahoo.com (web32203.mail.mud.yahoo.com
	[68.142.207.134]) by ozlabs.org (Postfix) with SMTP id 091DB67D75
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 14:35:22 +1000 (EST)
Message-ID: <20050728042840.36296.qmail@web32203.mail.mud.yahoo.com>
Date: Wed, 27 Jul 2005 21:28:40 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn>,
	linuxppc-embedded@ozlabs.org
In-Reply-To: <A9DE2BAF233E444FA9C5E77A5825A01E8652D4@ydmail.sbell.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Re: How to load a linux kernel under vxworks bootloader (PPC860
	board)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--- FCG WANG Baohua <Baohua.WANG@alcatel-sbell.com.cn> wrote:

> Dear All:
>   I want to boot a linux 2.4.25 kernel under vxworks
> bootloader. When I using flat mode(0x200000 -->  0x10000)
> kernel  uncompressed ELF format ( vmlinux ),
>  and download it using TFTP of vxworks, it print the "starting
> at 0x1000 ...." and  freeze.  No input or output on serial
> port.
>  The version of vxworks is 5.3.1. 
>  can you give me some detail advice or give me a tool to slove
> it? thanks !

Do what I did:
Replace the vxWorks rom with you u-boot and you can boot Linux
or vxWorks with the same bootloader.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
