To: linuxppc-embedded@lists.linuxppc.org
From: Martin Egholm Nielsen <martin@egholm-nielsen.dk>
Subject: Re: Interrupt handling triggered by GPIO-input on 405EP?
Date: Tue, 18 May 2004 17:01:22 +0200
Message-ID: <40AA2542.5060306@egholm-nielsen.dk>
References: <c8cvjr$m40$1@sea.gmane.org> <008a01c43ce1$9a65fda0$0301a8c0@chuck2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <008a01c43ce1$9a65fda0$0301a8c0@chuck2>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Mark,

>>However, the way the application is at the moment I need to poll the
>>input-ports every so often in order to detect a pushbutton-activation.
>>Hence, I would like to register an interrupt-handler (of some sort) that
>>informs me when these events occur. Is that somehow possible?
> I don't know this hardware so I don't know if you can bring the GPIO into an
> actual IRQ line.
Well, according to the manual GPIO0_17-23 (IRQ 0-6) is connected to
interrupt 25-31, but I have no clue how to utilise that...

> But if you can't, a pretty efficient way to poll the GPIO is to hook into
> the heartbeat timer (100Hz, 10ms).
=== SNIP ===
> I've only done this from within a device driver, btw - the app opens
> /dev/mydevice and gets a character whenever the gpio (in my case a keypad)
> changes.
So you've created your own device-driver on top of the gpio-dev.-driver?
  And what kind of device is this? Does the driver buffer keypad inputs
even if the device is not open?
Can you please post a source example describing this in further details?

Regards,
  Martin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
