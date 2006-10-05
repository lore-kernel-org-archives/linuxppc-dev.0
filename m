Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 5C3F167DC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Oct 2006 00:28:27 +1000 (EST)
In-Reply-To: <20061005092946.2004afu1wwc4kkcg@webmail.mcgill.ca>
References: <20061005092946.2004afu1wwc4kkcg@webmail.mcgill.ca>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AAFDE188-1AA7-4808-9713-883C73BB5E57@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: Compiler Question
Date: Thu, 5 Oct 2006 09:28:47 -0500
To: wei.li4@elf.mcgill.ca
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

These requirements are part of the Application Binary Interface, or  
ABI for short.  Since you're posting to the Linux embedded list, I  
assume you want the general powerpc 32-bit ABI.  This can be found at

http://refspecs.freestandards.org/elf/elfspec_ppc.pdf

and other places on the web.

There's also a 32-bit powerpc Embedded ABI (not used by Linux).  Some  
tool and OS vendors use this ABI instead of the one above.  A quick  
googling of this shows a copy can be found at http:// 
www.cloudcaptech.com/MPC555%20Resources/Programming%20Environment/ 
ppceabi.pdf#search=%22powerpc%20eabi%22

Cheers,
B


On Oct 5, 2006, at 8:29 AM, wei.li4@elf.mcgill.ca wrote:

> Hi All,
>
> It seems that there is a rule that Compiler or Linker assigns r3, r4
> ... to the arguments of C function when it is called, and r1 is the
> address of Stack Pointer, and how is for r0 and r2? where can I find
> these rules? Thanks.
>
> Wei
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
