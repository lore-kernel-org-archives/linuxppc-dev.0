Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id D4F6D67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 10:56:28 +1100 (EST)
Message-ID: <423A1927.1080800@mvista.com>
Date: Thu, 17 Mar 2005 16:56:23 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Brian Waite <waite@skycomputers.com>
References: <200503170953.02626.waite@skycomputers.com>	<4239C1FD.7060308@mvista.com>
	<200503171247.20161.waite@skycomputers.com>
In-Reply-To: <200503171247.20161.waite@skycomputers.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: 0/2 add support for Sky Computers HDPU Compute
 blade
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Brian Waite wrote:

>On Thursday 17 March 2005 12:44, Mark A. Greer wrote:
>  
>
>>Brian Waite wrote:
>>
>>    
>>
>>>+#define HDPU_INTERNAL_SRAM_BASE               0xfbfc0000
>>>+#define HDPU_INTERNAL_SRAM_SIZE               0x00040000
>>> 
>>>
>>>      
>>>
>>I haven't gone through in detail yet but one thing I did notice was that 
>>you don't have the proper SRAM alignment or size.  The SRAM on the 
>>64[34]60 is 2MB so it must be aligned on a boundary that's a multiple of 
>>2MB.
>>
>>    
>>
>Mark, 
>	Argh that is a carry over from a bad experiment in consolidating memory space. 
>I don't use the SRAM for anything so it will not break the code so I will provide a patch on top 
>of the platform patch to fix this if that works for you.
>  
>

Brian,

I stand corrected.  Dale Farnsworth pointed out to me that its 2Mb (as 
in "bit") not byte.  I was reading the manual wrong.

Sorry 'bout that.

Mark
