From: Benjamin Herrenschmidt <bh40@calva.net>
To: <daenzerm@student.ethz.ch>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree86 version 4.01
Date: Tue, 25 Jul 2000 16:44:01 +0200
Message-Id: <20000725144401.19702@mailhost.mipsys.com>
In-Reply-To: <397D98EC.2E9C36C3@relog.ch>
References: <397D98EC.2E9C36C3@relog.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>So it looks like that bug still isn't fixed.
>
>Ani, Ben, Kostas, Kevin: Any reason the r128 driver can't use fbdevhw to set
>up modes? (like glint)
>
>
>> > If the internal video isn't the default framebuffer device (where the
>> > initial console comes up on), you'll have to add
>> >
>> >       Option  "fbdev" "/dev/fb1"
>> >
>> yup, this was exactly what I needed, unfortunately althought i definetely
>> is finding this monitor it is not working either.  However I suspect this
>> is a monitor config issue and will keep working on it (or maybe try
>> another monitor).
>
>Does the console work there? If yes, just don't specify any modelines and it
>will use the console mode.
>
>And beware: With Xinerama, all screens must have the same depth...

I didn't follow the thread from the beginning, so I may have missed
something. The r128 driver on top of fbdev works nicely for me and all
machines I've tested so far (g4 and Pismo). Note however that the stock
XF4.0.1 don't have the patch to probe PLL values from the card and may be
working with incorrect hard-coded values.

I think Franz Sirl RPMs do have the probe code.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
