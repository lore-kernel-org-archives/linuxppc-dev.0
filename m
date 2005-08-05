Return-Path: <geoffrey.levand@am.sony.com>
Message-ID: <42F3D64C.2040800@am.sony.com>
Date: Fri, 05 Aug 2005 14:12:44 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Bogdan Antonovici <bantonovici@priority.mb.ca>
References: <1121959795.800.18.camel@rd-lab>	<1a928a85f53f5dcd972161356611a312@embeddededge.com>
	<00ca01c599f1$a2411730$cd01a8c0@DESIGNLAB>
In-Reply-To: <00ca01c599f1$a2411730$cd01a8c0@DESIGNLAB>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org,
	ppckernel <ppckernel@ppckernel.org>
Subject: Re: swap_dup: Bad swap file entry 00480020
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BTW, I posted a fix for a bug in the 2.6 page table attribute
settings for PPC440 that cause corruption when swapping.  I 
don't know if is the same for 2.4.

http://patchwork.ozlabs.org/linuxppc/patch?id=1458

-Geoff

Bogdan Antonovici wrote:
> Dan,
>  
> It hasn't crashed since i corrected that pointer initialization in
> driver. You were right.
> Thank you.
> Bogdan
> 
> ----- Original Message ----- 
> From: Dan Malek <mailto:dan@embeddededge.com>  
> To: bogdan antonovici <mailto:bantonovici@priority.mb.ca>  
> Cc: linuxppc-dev <mailto:linuxppc-dev@ozlabs.org>  ;
> linuxppc-embedded@ozlabs.org <mailto:linuxppc-embedded@ozlabs.org>  ;
> ppckernel <mailto:ppckernel@ppckernel.org>  
> Sent: Thursday, July 21, 2005 12:59 PM
> Subject: Re: swap_dup: Bad swap file entry 00480020
> 
> 
> On Jul 21, 2005, at 11:29 AM, bogdan antonovici wrote:
> 
> 
>>At the time of swap messages i was running a proprietary driver, my
>>application and few daemons.
> 
> 
> Looks like your driver may have written over some of the page
> tables in the kernel space.
> 
> 
>>I look on the net for some clues but it's quite confusing, i noticed
>>many emails on swap_dup/swap_free error messages but i couldn't figure
>>out what should i search for.
> 
> 
> Those messages are likely due to a bug with swapping to disk
> that has been in some 2.4 kernels, but I don't believe that is
> the case here, since you don't have a disk or swapping enabled.
> 
> 
> -- Dan
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
