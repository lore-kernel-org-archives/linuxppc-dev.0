Return-Path: <cbf123@mail.usask.ca>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 866CA2C034A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 07:23:43 +1000 (EST)
Message-ID: <51DF2229.5010604@mail.usask.ca>
Date: Thu, 11 Jul 2013 15:22:49 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
To: Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>,
 <kexec@lists.infradead.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
References: <51DF1BBB.5060904@mail.usask.ca>
In-Reply-To: <51DF1BBB.5060904@mail.usask.ca>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 02:55 PM, Chris Friesen wrote:
> Hi,
>
> I'm running 2.6.34 with kexec 2.0.1 on a Freescale p5020-based system
> with 8GB of memory.  (It's an embedded system and I can't do much
> about the fact that it's using older software.)

I should probably clarify this...I may be able to update kexec, I can't 
update the kernel but I can backport more recent code if necessary.

Looking at the version of kexec that I have, it seems like where x86 
uses "memmap=" to specify the memory map usable by the capture kernel, 
powerpc does something different.

Chris
