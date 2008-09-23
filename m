Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D2CF8DDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 07:32:14 +1000 (EST)
Message-ID: <48D96052.6090005@ru.mvista.com>
Date: Wed, 24 Sep 2008 01:32:02 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 3/3] USB: driver for Freescale QUICC Engine USB
	Host	Controller
References: <20080918151659.GA20140@oksana.dev.rtsoft.ru>	<20080918151746.GC31187@oksana.dev.rtsoft.ru>	<20080919162324.e354ed2f.akpm@linux-foundation.org>
	<20080923183129.GA19024@oksana.dev.rtsoft.ru>
In-Reply-To: <20080923183129.GA19024@oksana.dev.rtsoft.ru>
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

Hello.

Anton Vorontsov wrote:

>>> This patch adds support for the FHCI USB controller, as found
>>> in the Freescale MPC836x and MPC832x processors. It can support
>>> Full or Low speed modes.
>>>
>>> Quite a lot the hardware is doing by itself (SOF generation, CRC
>>> generation and checking), though scheduling and retransmission is on
>>> software's shoulders.
>>>
>>> This controller does not integrate the root hub, so this driver also
>>> fakes one-port hub. External hub is required to support more than
>>> one device.
>>>
>>> ...
>>>
>>>       
>> Please, no.
>>     
>
> What exactly 'no'? ;-)
>   

   No one-port hubs I guess -- they are pointless. Though e.g. MUSB 
driver creates one -- I guess to impersonate a transaction translating 
high-speed hub...

WBR, Sergei
