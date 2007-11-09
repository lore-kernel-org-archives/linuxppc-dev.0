Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 3CC30DDE2C
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 05:35:31 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so1382129pyi
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Nov 2007 10:35:31 -0800 (PST)
Date: Fri, 9 Nov 2007 12:35:22 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: PPC440EPx on Sequoia: /proc/iomem acts weird
Message-ID: <20071109123522.072bc1d8@weaponx>
In-Reply-To: <4734A72B.2070104@harris.com>
References: <4734A72B.2070104@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 09 Nov 2007 13:30:03 -0500
"Steven A. Falco" <sfalco@harris.com> wrote:

> If I cat /proc/iomem on a Sequoia board, it never stops printing.  Here 
> are the first 10 lines:
> 
> bash-3.00# head -10 /proc/iomem
> e0000100-e000017f : usb
>   e0000100-e000017f : musbhsfc_udc
> e0000300-e000038f : ehci_hcd
> 180000000-18fffffff : /plb/pci@1eec00000
>           1d0000000-1d0001fff : ndfc
>           1d0000000-1d0001fff : ndfc
>           1d0000000-1d0001fff : ndfc
>           1d0000000-1d0001fff : ndfc
>           1d0000000-1d0001fff : ndfc
>           1d0000000-1d0001fff : ndfc
> 
> Basically, the last line (regarding the nand flash) keeps repeating 
> "forever".
> 
> Is anyone else seeing this behavior?  My kernel is 2.6.23 with Xenomai 
> patched in.

Erm.. 2.6.23?  There is no Sequoia support in arch/ppc or arch/powerpc
for 2.6.23 in the official trees.  What is Xenomai?  You should
probably talk to them.

josh
