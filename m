Date: Tue, 6 Apr 2004 16:09:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tolunay Orkun <listmember@orkun.us>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Question on RTC options (CONFIG_RTC, CONFIG_GEN_RTC, CONFIG_PPC_RTC)
Message-ID: <20040406230911.GK31152@smtp.west.cox.net>
References: <15133.216.110.51.8.1081278001.squirrel@www.orkun.us> <20040406200057.GB31152@smtp.west.cox.net> <19625.216.110.51.8.1081285199.squirrel@www.orkun.us> <20040406211439.GD31152@smtp.west.cox.net> <20701.216.110.51.8.1081286606.squirrel@www.orkun.us> <20040406213226.GE31152@smtp.west.cox.net> <22219.216.110.51.8.1081288263.squirrel@www.orkun.us> <20040406220221.GG31152@smtp.west.cox.net> <24063.216.110.51.8.1081292617.squirrel@www.orkun.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24063.216.110.51.8.1081292617.squirrel@www.orkun.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Apr 06, 2004 at 06:03:37PM -0500, Tolunay Orkun wrote:

> >> Do you happen know what it would take to use the DS1307 driver from LM
> >> Sensors package? Has anyone used LMSensors with PPC Linux?
> >
> > LM Sensors implies i2c, which means you'd have to use that, or add a few
> > more hooks to genrtc (a probe is required for i2c, but not others, maybe
> > others) to get it working w/ that driver.  But you'd still be using the
> > main i2c subsystem, which I think you've said is too heavy.
>
> No, I already use i2c on this board so i2c driver is included in kernel
> configuration. We bring the i2c bus to a header for communication with
> some external devices already.

Ah, OK.

> My concern about bloat from rest of LM Sensors. I am not sure if I can
> take ds1307 driver from sensors package and include in my build and if so
> how/how much additional code to provide /dev/rtc support working.

It should not be too hard, nor too bloaty.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
