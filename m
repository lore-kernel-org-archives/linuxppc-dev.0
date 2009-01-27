Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 77DB6DDF39
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 17:50:34 +1100 (EST)
Message-ID: <497EAEAF.3010108@trimble.com>
Date: Tue, 27 Jan 2009 00:50:23 -0600
From: Mike Timmons <mike_timmons@trimble.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: any luck with wireless USB adaptors?
References: <497E81DD.9020408@trimble.com>
	<fa686aa40901262101r48771b8oc9fdbb6a0ede01e8@mail.gmail.com>
In-Reply-To: <fa686aa40901262101r48771b8oc9fdbb6a0ede01e8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Reply-To: mike_timmons@trimble.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks. Yes, USB  wi fi is what I'm after.  I did find the driver I 
needed after enabling the WLAN80211 and EXPERIMENTAL options. The device 
discovery appears to work, and with wireless tools I can iwconfig and 
see my interface.

QUESTION: when I "ifoncfig wlan0 up" it results in an attempt to load a 
firmwmare file as follows. as you can see, it fails. What are these 
firmware files? I can't find it in my build output. How do I build it or 
where do I get it? Where would I put it on my target?

I did search for answers to these questions and tried to stick an 
rt73.bin of unknown origin (to me anyway) in /lib/firmware but I got the 
same error.

-sh-2.05b# ifconfig wlan0 up
[ 2212.027071] phy1 -> rt2x00lib_request_firmware: Info - Loading 
firmware file 'rt73.bin'.
[ 2272.058793] phy1 -> rt2x00lib_request_firmware: Error - Failed to 
request Firmware.
SIOCSIFFLAGS: No such file or directory

Thanks again,
Mike



\
Grant Likely wrote:
> On Mon, Jan 26, 2009 at 8:39 PM, Mike Timmons <mike_timmons@trimble.com> wrote:
>   
>> I'm running 2.6.24 with Freescale's lite5200 as my base. I'm interested in
>> this USB adaptor for wireless USB, but my web search does not make me
>> confident that my effort will yield fruit.
>>
>> Can anyone direct me to a good source outlining success stories with
>> wireless USB adaptors? At present I'm mesing with Linksys WUSB54GC and some
>> driver source from Ralink, but my cross-compile is not working.
>>     
>
> Umm, the WUSB54GC is not a "wireless USB" adapter.  It is a USB WiFi
> adapter.  If you're looking for wireless USB then it is the wrong
> device.
>
> If you are looking for a suitable wifi adapter, then that device
> should work, but if you can go with a PCI or a miniPCI WiFi adapter
> instead then you should get better performance.  The 5200 only has USB
> 1.1.
>
> I'm having good success with an Atheros miniPCI adapter at the moment
> using a 2.6.28 kernel.
>
> g.
>   
