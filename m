Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 06A42DDF25
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 08:57:33 +1000 (EST)
Date: Wed, 24 Sep 2008 02:57:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 3/3] USB: driver for Freescale QUICC Engine USB Host
	Controller
Message-ID: <20080923225730.GB13617@oksana.dev.rtsoft.ru>
References: <20080918151659.GA20140@oksana.dev.rtsoft.ru>
	<20080918151746.GC31187@oksana.dev.rtsoft.ru>
	<20080919162324.e354ed2f.akpm@linux-foundation.org>
	<20080923183129.GA19024@oksana.dev.rtsoft.ru>
	<48D96052.6090005@ru.mvista.com> <48D9612D.7060601@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48D9612D.7060601@ru.mvista.com>
Cc: dbrownell@users.sourceforge.net, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, leoli@freescale.com,
	timur@freescale.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 24, 2008 at 01:35:41AM +0400, Sergei Shtylyov wrote:
[...]
>>>>> This controller does not integrate the root hub, so this driver also
>>>>> fakes one-port hub. External hub is required to support more than
>>>>> one device.
>>>>>
>>>>> ...
>>>>>
>>>>>       
>>>> Please, no.
>>>>     
>>>
>>> What exactly 'no'? ;-)
>>>   
>>
>>   No one-port hubs I guess -- they are pointless. Though e.g. MUSB  
>> driver creates one -- I guess to impersonate a transaction translating  
>> high-speed hub...
>>
>
>   ... then the root hub emulation is completely pointless.

It isn't. We always should emulate the root hub. The root hub
is part and parcel of any USB Host. Even the one-port one.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
