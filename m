Return-Path: <listmember@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A41D2BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 10:19:35 +1100 (EST)
Message-ID: <41E6AAC7.1040105@orkun.us>
Date: Thu, 13 Jan 2005 11:07:19 -0600
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: Aubrey Lee <aubrey1127@gmail.com>
References: <7f834d4e0501130050666b757a@mail.gmail.com>
In-Reply-To: <7f834d4e0501130050666b757a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: About Zebra Error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Aubrey Lee wrote:
>  hi, In the PC(i686) system, I build and run zebra successfully. And now
> I'm porting it to the powerpc system. Cross-compiling finished without error.
> But when I run the zebra from my target board, it gives me  a big headache:
> --------------------------------------------------------------------------  
> bash-2.05b# /opt/zebra/sbin/zebra
>              sock: Address family not supported by protocol
> ----------------------------------------------------------------------------
> And Up to now I cann't find the message in the souce 
> code files.  

You are probably missing the particular socket type Zebra is trying to 
use. I had a similar experience while trying to use DHCP in busybox on 
by PPC405 embedded system. Go over your kernel configuration and ask a 
Zebra mailing list regarding the socket support it needs.
