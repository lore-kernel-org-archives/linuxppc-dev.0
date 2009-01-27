Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id C935DDE0D4
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 01:16:18 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so1600414qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 06:16:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <497EAEAF.3010108@trimble.com>
References: <497E81DD.9020408@trimble.com>
	<fa686aa40901262101r48771b8oc9fdbb6a0ede01e8@mail.gmail.com>
	<497EAEAF.3010108@trimble.com>
Date: Tue, 27 Jan 2009 09:10:00 -0500
Message-ID: <9e4733910901270610qd40bbacm8f1f1bf0bcc63ae9@mail.gmail.com>
Subject: Re: any luck with wireless USB adaptors?
From: Jon Smirl <jonsmirl@gmail.com>
To: mike_timmons@trimble.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 27, 2009 at 1:50 AM, Mike Timmons <mike_timmons@trimble.com> wrote:
> Thanks. Yes, USB  wi fi is what I'm after.  I did find the driver I needed
> after enabling the WLAN80211 and EXPERIMENTAL options. The device discovery
> appears to work, and with wireless tools I can iwconfig and see my
> interface.
>
> QUESTION: when I "ifoncfig wlan0 up" it results in an attempt to load a
> firmwmare file as follows. as you can see, it fails. What are these firmware
> files? I can't find it in my build output. How do I build it or where do I
> get it? Where would I put it on my target?

Kconfig
Device drivers
  generic driver options
     user space firmware support
        check - include in-kernel firmware blobs in kernel binary

>
> I did search for answers to these questions and tried to stick an rt73.bin
> of unknown origin (to me anyway) in /lib/firmware but I got the same error.
>
> -sh-2.05b# ifconfig wlan0 up
> [ 2212.027071] phy1 -> rt2x00lib_request_firmware: Info - Loading firmware
> file 'rt73.bin'.
> [ 2272.058793] phy1 -> rt2x00lib_request_firmware: Error - Failed to request
> Firmware.
> SIOCSIFFLAGS: No such file or directory
>
> Thanks again,
> Mike
>
>
>
> \
> Grant Likely wrote:
>>
>> On Mon, Jan 26, 2009 at 8:39 PM, Mike Timmons <mike_timmons@trimble.com>
>> wrote:
>>
>>>
>>> I'm running 2.6.24 with Freescale's lite5200 as my base. I'm interested
>>> in
>>> this USB adaptor for wireless USB, but my web search does not make me
>>> confident that my effort will yield fruit.
>>>
>>> Can anyone direct me to a good source outlining success stories with
>>> wireless USB adaptors? At present I'm mesing with Linksys WUSB54GC and
>>> some
>>> driver source from Ralink, but my cross-compile is not working.
>>>
>>
>> Umm, the WUSB54GC is not a "wireless USB" adapter.  It is a USB WiFi
>> adapter.  If you're looking for wireless USB then it is the wrong
>> device.
>>
>> If you are looking for a suitable wifi adapter, then that device
>> should work, but if you can go with a PCI or a miniPCI WiFi adapter
>> instead then you should get better performance.  The 5200 only has USB
>> 1.1.
>>
>> I'm having good success with an Atheros miniPCI adapter at the moment
>> using a 2.6.28 kernel.
>>
>> g.
>>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Jon Smirl
jonsmirl@gmail.com
