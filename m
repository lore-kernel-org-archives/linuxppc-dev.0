Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 48F7468A1F
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Feb 2006 19:42:41 +1100 (EST)
Message-ID: <43E5BAE8.9000507@compulab.co.il>
Date: Sun, 05 Feb 2006 10:44:24 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: CPM2 USB driver & MPC8248
References: <200602031210.12603.laurent.pinchart@tbox.biz>
In-Reply-To: <200602031210.12603.laurent.pinchart@tbox.biz>
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

Laurent,

[snip]

>When I connect a USB 2.0 Mass Storage device, initialization fails when trying 
>to fetch the string descriptors. Here's what USBMon produces (I decoded the 
>USB transactions with the device).
>  
>
[snip]

I had similar problems with mass storage devices (disk-on-key). I've 
tried to find out what was causing them but I hadn't much success with it.
I think that problem might be in driver performance because it is very 
far from optimal.
Another thing that may cause problems is how storage devices treat SOF 
packets, but I'm not USB expert enough to be sure about that.

>As you can see, the devices sends its device and configuration descriptors, 
>but something goes wrong with the string descriptors. I modified the core USB 
>code to request 0x40 bytes (which is the value of bMaxPacketSize0) or even 
>0x20 bytes, but the same problem occurs (same USBMon traces with 0xff 
>replaced by 0x40).
>
>Could you help me ? Kernel coding is not a problem, so I can make experiments 
>if you point me to some direction. I'm also quite familiar with the USB specs 
>down to the various types of transfers (control, interrupt, bulk and 
>isochronous) but not with the lower-level protocol (frames, tokens, ...). I 
>can learn if needed.
>
>Laurent Pinchart
>
>
>
>  
>

-- 
Sincerely yours,
Mike Rapoport
