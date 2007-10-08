Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BAA12DDF16
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 02:08:08 +1000 (EST)
Message-ID: <470A55A2.5050606@ru.mvista.com>
Date: Mon, 08 Oct 2007 20:06:58 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [PATCH] OHCI: add PowerPC 440EP/440EPx support
References: <20071008142554.GA15175@ru.mvista.com>
	<20071008150125.26C802393C7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20071008150125.26C802393C7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Brownell wrote:
>> @@ -612,7 +612,7 @@ static inline u32 hc32_to_cpup (const st
>>   * to arch/powerpc
>>   */
>>  
>> -#ifdef CONFIG_STB03xxx
>> +#if defined(CONFIG_STB03xxx) || defined(CONFIG_440EP) || defined(CONFIG_440EPX)
>>  #define OHCI_BE_FRAME_NO_SHIFT	16
>>  #else
>>  #define OHCI_BE_FRAME_NO_SHIFT	0
> 
> Near as I can tell, the original code is wrong ... the hcca->frame_no
> byte offset is fully specified, so that shift should always be 16.
> 
> - Dave
> 
Are you saying that it should always be #define OHCI_BE_FRAME_NO_SHIFT 
16 for big endian platforms?
