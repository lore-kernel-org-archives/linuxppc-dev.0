Return-Path: <markc@mail.com>
Received: from smtp1.us4.outblaze.com (smtp1.us4.outblaze.com [205.158.62.78])
	by ozlabs.org (Postfix) with SMTP id AAF7D67A01
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 03:53:30 +1100 (EST)
Message-ID: <004901c64207$a31403c0$6401a8c0@CHUCK2>
From: "Mark Chambers" <markc@mail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
References: <927594BA71733F4BAA815162B79A3F513B2958@ala-mail04.corp.ad.wrs.com>
	<BAB64425-65CD-4311-9A93-004EBA27729A@kernel.crashing.org>
Subject: Re: Calling PCI Autoconfig again
Date: Tue, 7 Mar 2006 11:53:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
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

> I'm dealing with this exact same situation and having a discussion on  
> lkml regarding the proper way to do this.  In your case, do you care  
> what addresses the FPGA is assigned at?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114140791428032&w=2
> 

Why does the PCI device have to have a fixed address?   And how do
you load an FPGA from user space - mmap?

Mark C.
