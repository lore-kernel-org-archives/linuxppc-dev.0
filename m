Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 6F46367A73
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Feb 2005 04:08:45 +1100 (EST)
Message-ID: <421E0A13.7060309@mvista.com>
Date: Thu, 24 Feb 2005 10:08:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
References: <41F6E0E1.6000803@mvista.com> <20050224082508.GA30005@pegasos>
	<421DF2B8.6040007@mvista.com> <20050224160411.GA11197@pegasos>
In-Reply-To: <20050224160411.GA11197@pegasos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: nd@bplan-gmbh.de, Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH][PPC32] mv64x60 updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sven Luther wrote:

>On Thu, Feb 24, 2005 at 08:28:56AM -0700, Mark A. Greer wrote:
>  
>
>>Sven Luther wrote:
>>
>>    
>>
>>>On Tue, Jan 25, 2005 at 05:14:25PM -0700, Mark A. Greer wrote:
>>>
>>>
>>>      
>>>
>>has spent a lot of time making it work on both MIPS and PPC.  The code 
>>you see in the mv64x60.c file is a part of that.  I believe that Dale's 
>>    
>>
>
>Ok, so the code in question is in addition to the existing driver from the
>mips guys and works with it ?
>

If "the code in question" == the enet related code in mv64x60.c then 
yes.  However, the only enet related code in mv64x60 is platform_data 
setup and setup of the bridge's windows between the enet ctlr and system 
memory.

> I had the impression that it was a separate
>driver development or something.
>

Nope.

>
>  
>
>>patch(es) have been accepted and are queued to go into the mainline tree 
>>at some point.
>>    
>>
>
>Ok. Do you know if Dale's patches are available separatedly while they are not
>yet in mainline, so Nicolas Det can work on them and make sure they also work
>on the Pegasos board, which is not an embedded board but from the chrp
>lineage. Nicolas already did some mv643xx ethernet driver work last summer,
>but apparently had trouble integrating this in the mainline kernel, and it
>seems his work has now been redone by Dale or something. Do you know who the
>right person to communicate with about this would be ? The MIPS folk didn't
>reply to any of our mails about this subject.
>

Nicolas has emailed me off-line and he & Dale are now in contact.  FYI, 
this is part of the email from Dale to Nicolas:

>  Please see bk://dfarnsworth@bkbits.net/linux-2.5-mv643xx-enet.  Most of this is
> in netdev and mm, and on track to go into linux-2.5.


>>Did I answer your question?
>>    
>>
>
>I think so. I was just surprised to see this 64x6x work go to arch/ppc instead
>to drivers/net.
>

There is no "driver" functionality in arch/ppc.  There is only 
platform_data setup which is used by the driver and the ensuring the 
bridge's windows between the enet ctlr and system memory are set up 
correctly.

Mark
