Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 6E5CA67B39
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 04:40:04 +1000 (EST)
Message-ID: <4256CFFF.20701@mvista.com>
Date: Fri, 08 Apr 2005 11:39:59 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Ho Lee <flylist@linuxkernel.net>
References: <F38DEABE0E171746B133C1ABBD142D9703691AFD@radmail.Radstone.Local>
	<013c01c53c63$8b4e98e0$0d02a8c0@acting>
In-Reply-To: <013c01c53c63$8b4e98e0$0d02a8c0@acting>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MTD Mapping driver - out of vmalloc space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ho Lee wrote:

>
> Hi Chris,
>
> How about setting PAGE_OFFSET to 0x80000000, that is 2G/2G split?
> It would make enough virtual address space. I've never tried on PPC,
> so I don't know the side effect of this.
> -- Ho
>

Chris,

Like Ho says, you need to lower PAGE_OFFSET (although you may not want 
to drop it all the way to 0x80000000).  That will increase your vmalloc 
space.  On ppc, you do this via the 'Advanced setup' config menu.

Mark
