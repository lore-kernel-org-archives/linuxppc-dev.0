Return-Path: <suvidh.kankariya@ntigo.com>
Received: from nti1.com (nti1.com [65.243.248.10])
	by ozlabs.org (Postfix) with ESMTP id 05AF4DE42D
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 05:59:06 +1000 (EST)
Message-ID: <48372238.7010501@ntigo.com>
Date: Fri, 23 May 2008 15:59:53 -0400
From: Suvidh Kankariya <suvidh.kankariya@ntigo.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: help with USB on mpc8313e
References: <48370DB6.7030003@ntigo.com>
	<20080523192049.GA14572@polina.dev.rtsoft.ru>
In-Reply-To: <20080523192049.GA14572@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Anton,
With the kernel version 2.6.20 I am using Majority of this changes are 
hard code values in mpc8313.c
I did already changed this value for my custom board file.
But I am getting  the error irrespectively.

Is the relatonship description between USB DR clk and other as mentioned 
in your thread  is documented in the manual . I could not find it 
atleast in mpc8313e user manual.


Regards

Suvidh





Anton Vorontsov wrote:
> On Fri, May 23, 2008 at 02:32:22PM -0400, Suvidh Kankariya wrote:
>   
>> Hi,
>> I am trying to use the mpc8313e internal usb phy with internal  
>> oscillator frequency of  24 Mz. in host mode on a custom board.
>> Whenever I plugin any low/fast speed device the device gets detected but  
>> then always get an error
>> "cannot read descriptor 64  error 71".Also I get address error after that .
>>
>> Can somebody point me what this error can be related to ?Can it be a  
>> problem with ehci drivers or some configuration. (I get a valid clock  
>> bit set in the status register).
>>     
>
> This reminds me: http://patchwork.ozlabs.org/linuxppc/patch?id=17782
> Was getting exactly same symptoms.
>
> Try similar changes, should help.
>
>   
>> Also can someone point me how I include support for mmc on spi. I am  
>> using kernel 2.6.20 that comes along with mpc8313e bsp.
>>
>> Any pointers are highly appreciable.
>>
>> Thanks in advance
>> Regards
>>
>> Suvidh
>>     
>
>   
