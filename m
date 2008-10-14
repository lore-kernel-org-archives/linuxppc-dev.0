Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id B0B00DDEF1
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 21:55:22 +1100 (EST)
Received: from [192.168.1.37] (66-81-70-26.bayarea.dialup.o1.com [66.81.70.26])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m9EArj09057978
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 03:55:13 -0700 (PDT)
Message-ID: <48F479ED.1030500@hypersurf.com>
Date: Tue, 14 Oct 2008 03:52:29 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
CC: linuxppc-dev@ozlabs.org
Subject: Re: gigE 2.6.27 USB
References: <48F32451.7020303@hypersurf.com>
In-Reply-To: <48F32451.7020303@hypersurf.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kevin Diggs wrote:
> Hi,
> 
>     I managed to wrestle my gigE to the ground and get it to boot
> 2.6.27. I have, however, noticed that some messages are showing up in
> dmesg. There are alot of them. They are continuous. They appear to come
> from drivers/usb/core/hub.c:2916. It looks like they come in pairs (this
> beast has two ports (root hubs)). I plugged in a USB CF reader. It
> appears to work. The keyboard and mouse (a Logitech wireless receiver)
> seems to work. 2.6.24 did not do this.
> 
> kevin
> 
	For what it is worth, I tricked a laptop into booting 2.6.27. It
does not appear to generate these messages. The PowerMac is running
Yellow Dog 4.

kevin
