Message-ID: <24063.216.110.51.8.1081292617.squirrel@www.orkun.us>
In-Reply-To: <20040406220221.GG31152@smtp.west.cox.net>
References: <15133.216.110.51.8.1081278001.squirrel@www.orkun.us>
    <20040406200057.GB31152@smtp.west.cox.net>
    <19625.216.110.51.8.1081285199.squirrel@www.orkun.us>
    <20040406211439.GD31152@smtp.west.cox.net>
    <20701.216.110.51.8.1081286606.squirrel@www.orkun.us>
    <20040406213226.GE31152@smtp.west.cox.net>
    <22219.216.110.51.8.1081288263.squirrel@www.orkun.us>
    <20040406220221.GG31152@smtp.west.cox.net>
Date: Tue, 6 Apr 2004 18:03:37 -0500 (CDT)
Subject: Re: Question on RTC options (CONFIG_RTC, CONFIG_GEN_RTC,
      CONFIG_PPC_RTC)
From: "Tolunay Orkun" <listmember@orkun.us>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> Do you happen know what it would take to use the DS1307 driver from LM
>> Sensors package? Has anyone used LMSensors with PPC Linux?
>
> LM Sensors implies i2c, which means you'd have to use that, or add a few
> more hooks to genrtc (a probe is required for i2c, but not others, maybe
> others) to get it working w/ that driver.  But you'd still be using the
> main i2c subsystem, which I think you've said is too heavy.

No, I already use i2c on this board so i2c driver is included in kernel
configuration. We bring the i2c bus to a header for communication with
some external devices already.

My concern about bloat from rest of LM Sensors. I am not sure if I can
take ds1307 driver from sensors package and include in my build and if so
how/how much additional code to provide /dev/rtc support working.

I can also drop /dev/rtc completely and write a userland application
similar to hwclock and use it to do /dev/i2c I/O to RTC but would like to
standard scheme as much as possible.

Best regards,
Tolunay


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
