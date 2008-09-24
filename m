Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 6E2B7DDDFA
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 20:49:08 +1000 (EST)
Message-ID: <48DA1B1A.8050507@ru.mvista.com>
Date: Wed, 24 Sep 2008 14:48:58 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 3/3] USB: driver for Freescale QUICC Engine
	USB	Host	Controller
References: <20080918151659.GA20140@oksana.dev.rtsoft.ru>	<20080918151746.GC31187@oksana.dev.rtsoft.ru>	<20080919162324.e354ed2f.akpm@linux-foundation.org>	<20080923183129.GA19024@oksana.dev.rtsoft.ru>	<48D96052.6090005@ru.mvista.com>
	<48D9612D.7060601@ru.mvista.com>	<20080923225730.GB13617@oksana.dev.rtsoft.ru>
	<48DA1544.5010307@ru.mvista.com>
In-Reply-To: <48DA1544.5010307@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, leoli@freescale.com,
	timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

>>>>>>> This controller does not integrate the root hub, so this driver 
>>>>>>> also
>>>>>>> fakes one-port hub. External hub is required to support more than
>>>>>>> one device.
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>                   
>>>>>> Please, no.
>>>>>>               
>>>>> What exactly 'no'? ;-)
>>>>>           
>>>>   No one-port hubs I guess -- they are pointless. Though e.g. MUSB  
>>>> driver creates one -- I guess to impersonate a transaction 
>>>> translating  high-speed hub...
>>>>
>>>>       
>>>   ... then the root hub emulation is completely pointless.
>>>     
>>
>> It isn't. We always should emulate the root hub. The root hub
>> is part and parcel of any USB Host. Even the one-port one.
>
>   Hm, maybe that's what USB core thinks (because UHCI/OHCI/EHCI all 
> have it) but e.g. MUSB doesn't have the root hub registers...

   Oops, I stand corrected. Even USB 1.1 specifies that it must be a 
part the host...

WBR, Sergei
