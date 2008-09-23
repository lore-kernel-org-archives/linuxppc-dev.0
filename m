Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 3A92CDDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 07:35:50 +1000 (EST)
Message-ID: <48D9612D.7060601@ru.mvista.com>
Date: Wed, 24 Sep 2008 01:35:41 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 3/3] USB: driver for Freescale QUICC Engine USB
	Host	Controller
References: <20080918151659.GA20140@oksana.dev.rtsoft.ru>	<20080918151746.GC31187@oksana.dev.rtsoft.ru>	<20080919162324.e354ed2f.akpm@linux-foundation.org>
	<20080923183129.GA19024@oksana.dev.rtsoft.ru>
	<48D96052.6090005@ru.mvista.com>
In-Reply-To: <48D96052.6090005@ru.mvista.com>
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

>>>> This patch adds support for the FHCI USB controller, as found
>>>> in the Freescale MPC836x and MPC832x processors. It can support
>>>> Full or Low speed modes.

   Ah, it's not even high-speed?

>>>> Quite a lot the hardware is doing by itself (SOF generation, CRC
>>>> generation and checking), though scheduling and retransmission is on
>>>> software's shoulders.

   I imagine that must be worse than MUSB... :-/

>>>> This controller does not integrate the root hub, so this driver also
>>>> fakes one-port hub. External hub is required to support more than
>>>> one device.
>>>>
>>>> ...
>>>>
>>>>       
>>> Please, no.
>>>     
>>
>> What exactly 'no'? ;-)
>>   
>
>   No one-port hubs I guess -- they are pointless. Though e.g. MUSB 
> driver creates one -- I guess to impersonate a transaction translating 
> high-speed hub...
>

   ... then the root hub emulation is completely pointless.

WBR, Sergei
