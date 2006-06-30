Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s19.bay0.hotmail.com (bay0-omc3-s19.bay0.hotmail.com
	[65.54.246.219]) by ozlabs.org (Postfix) with ESMTP id 7BEF167B64
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Jul 2006 06:07:33 +1000 (EST)
Message-ID: <BAY110-F100DC6FCE1A39DABEF869AB27D0@phx.gbl>
In-Reply-To: <528646bc0606301302u5922945dycda569e6954fa353@mail.gmail.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: grant.likely@secretlab.ca
Subject: Re: Xilinx SystemACE driver for 2.6
Date: Fri, 30 Jun 2006 20:07:30 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Yes. I noticed that in the original demo Linux of MontaVista shipped by 
Xilinx for ML403, there is no swap partition. 

Regards
Ming


>From: "Grant Likely" <grant.likely@secretlab.ca>
>To: "Ameet Patil" <ammubhai@gmail.com>
>CC: "Ming Liu" <eemingliu@hotmail.com>, linuxppc-embedded@ozlabs.org
>Subject: Re: Xilinx SystemACE driver for 2.6
>Date: Fri, 30 Jun 2006 14:02:28 -0600
>
>On 6/30/06, Ameet Patil <ammubhai@gmail.com> wrote:
>>Here is PART I of the article:
>>http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/

>>
>>Let me know if you get messages at boot time after following the 
>>above...
>
>Quick comment on your article; unless you're using a microdrive;
>*PLEASE* don't recommend using compact flash as swap space.  Flash
>technology has limited write cycles (on the order of 100k to 1M 
>cycles
>per block).  Using it as swap is a great way to kill the lifecycle 
>of
>your device.
>
>(the ML300 ships with a microdrive; the ML40x ships with a regular 
>CF card)
>
>I know the previous article also recommends a swap partition, but
>Linux will happily run without swap.
>
>Cheers,
>g.
>
>--
>Grant Likely, B.Sc. P.Eng.
>Secret Lab Technologies Ltd.
>grant.likely@secretlab.ca
>(403) 399-0195

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
