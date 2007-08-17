Return-Path: <fvoegel@carangul.com>
Received: from asgard.akp-net.com (carangul.com [83.149.88.131])
	by ozlabs.org (Postfix) with ESMTP id BCBC1DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 23:50:44 +1000 (EST)
Date: Fri, 17 Aug 2007 16:53:33 +0200
From: "Florian A. Voegel" <fvoegel@carangul.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: some question about linux kernel in embed system
Message-Id: <20070817165333.35149133.fvoegel@carangul.com>
In-Reply-To: <200708171057543728507@taicom.com.cn>
References: <200708171019577288809@taicom.com.cn>
	<200708171028495734596@taicom.com.cn>
	<200708171057543728507@taicom.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: lim@taicom.com.cn
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

what kind of hardware are you using? Try passing the console device name you want to use on the kernel command line, ie console=<consoledev>

Greets,

Florian

On Fri, 17 Aug 2007 10:58:01 +0800
"李明" <lim@taicom.com.cn> wrote:

> hello everyone 
> I am doing some embed system works.
> Now I want to replant the linux-2.4.32 to my own system.
> But there are some questions.First let me introduce my heardware:
> I use powerpc+flash+sdram to buildup a mini system,use u-boot 1.1.4 as bootloader then I need to replant the kernel on it .
> The linux-2.4.32 kernel which was made a uImage, is running in this mini system, the question is appear:
>     Image Name:   Linux-2.4.32
>    Created:      2007-08-16  21:31:03 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    685809 Bytes = 669.7 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> then the kernel is dead, I do not know what is problem,please give me some clew,thanks!   
