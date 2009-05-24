Return-Path: <hunter.cobbs@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id D92AEDE09E
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 07:42:49 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1365093ywt.39
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 14:42:48 -0700 (PDT)
References: <23698384.post@talk.nabble.com>
Message-Id: <1FF3CEF7-4B89-458F-82C8-6091206E6809@gmail.com>
From: Hunter Cobbs <hunter.cobbs@gmail.com>
To: Mirek23 <miroslaw.dach@psi.ch>
In-Reply-To: <23698384.post@talk.nabble.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 5H11)
Subject: Re: U-boot and linux command line parameters
Date: Sun, 24 May 2009 16:41:40 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Have you considered using a kernel and initrd?

Hunter Cobbs

On May 24, 2009, at 4:38 PM, Mirek23 <miroslaw.dach@psi.ch> wrote:

>
> Dear All,
>
> I use linux kernel 2.6.23 and u-boot 1.2.0 (on ppc405 virtex-4 )  
> for  some
> time. All works fine when the
> kernel together with initramfs is smaller than 8MB. If it is bigger  
> than the
> kernel does not boot properly.
>
> First of all I would like to know how the address for the linux  
> command line
> parameters is "transferred" from u-boot to linux for ppc405 (virtex4  
> chip)?
> (via some registers or is it  a fixed address in the memory ie. 8MB?)
> Does somebody know what should be changed, in the kernel,  in order  
> to move
> this limitation from 8MB to let say 12MB? I would be grateful for  
> any hint.
>
> Thanks in advance.
> M.
> -- 
> View this message in context: http://www.nabble.com/U-boot-and-linux-command-line-parameters-tp23698384p23698384.html
> Sent from the linuxppc-dev mailing list archive at Nabble.com.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
