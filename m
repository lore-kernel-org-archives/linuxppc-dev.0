Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D1A05DDD06
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Feb 2007 07:45:07 +1100 (EST)
In-Reply-To: <32201137.34111171657512254.JavaMail.root@vms061.mailsrvcs.net>
References: <32201137.34111171657512254.JavaMail.root@vms061.mailsrvcs.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E6C97B4B-F3DF-4AEC-A225-60DC6AE05691@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: What happened to include/asm-ppc??
Date: Fri, 16 Feb 2007 14:45:00 -0600
To: "<blueskyjb@verizon.net>" <blueskyjb@verizon.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

They're probably in include/asm-powerpc/

You'll need both, since there are still some files in asm-ppc that  
are needed by the asm-powerpc stuff.

On Feb 16, 2007, at 14:25, <blueskyjb@verizon.net>  
<blueskyjb@verizon.net> wrote:

>
> I'm using lastest ELDK (4.1) with Linux 2.6.19.2.
> After upgrading from ELDK 4.0 I can't get any of
> my user apps to build.  The problem is that many
> of the headers that were in include/asm-ppc are
> now gone.  For example, posix_types.h and sigcontext.h.
> All the other arches seem to have a full complement
> of header files in their asm directories.  Can someone give me a  
> clue??  Thanks!
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
