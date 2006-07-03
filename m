Return-Path: <ammubhai@gmail.com>
Received: from mailgw.cs.york.ac.uk (mailgw.cs.york.ac.uk [144.32.40.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 895DE679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Jul 2006 19:12:06 +1000 (EST)
Message-ID: <44A8DDDA.6090604@gmail.com>
Date: Mon, 03 Jul 2006 10:05:30 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Xilinx SystemACE driver for 2.6
References: <BAY110-F40223AFCCAA679FBC5A962B27D0@phx.gbl>	
	<44A580F5.8050900@gmail.com>
	<528646bc0606301302u5922945dycda569e6954fa353@mail.gmail.com>
In-Reply-To: <528646bc0606301302u5922945dycda569e6954fa353@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Grant,
    I totally agree with you. What you say is correct. It will 
definitely kill the CF card. I use a XUPV2PRO board which doesn't come 
with a microdrive and for my research SWAP is a must. :-)

However, I shall add a NOTE in the article mentioning the same.

Thanks a lot,
-Ameet

Grant Likely wrote:
> On 6/30/06, Ameet Patil <ammubhai@gmail.com> wrote:
>> Here is PART I of the article:
>> http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/ 
>>
>>
>> Let me know if you get messages at boot time after following the above...
> 
> Quick comment on your article; unless you're using a microdrive;
> *PLEASE* don't recommend using compact flash as swap space.  Flash
> technology has limited write cycles (on the order of 100k to 1M cycles
> per block).  Using it as swap is a great way to kill the lifecycle of
> your device.
> 
> (the ML300 ships with a microdrive; the ML40x ships with a regular CF card)
> 
> I know the previous article also recommends a swap partition, but
> Linux will happily run without swap.
> 
> Cheers,
> g.
> 
