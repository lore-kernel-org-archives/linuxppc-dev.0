To: Eugene Surovegin <ebs@ebshome.net>
Cc: Miku Jha <jha_miku@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc440 and i2c 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 18 Nov 2003 00:08:43 PST."
             <20031118080843.GA28129@gate.ebshome.net>
Date: Tue, 18 Nov 2003 09:22:43 +0100
Message-Id: <20031118082248.38F8DC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20031118080843.GA28129@gate.ebshome.net> you wrote:
>
> Your problem sounds strange.

No. It's just that this version (out of 3 different in a total  of  5
messages  to  several  mailing lists I've seen so far!) does not even
explain the problem correctly.

It's just a known issue on the I2C bus.

> Are you saying that after 440GP _reset_ IIC line state affects 440 ?

No.

> If bootstrap IIC is accidentaly activated you may get problems if you
> have non-compliant/not-properly-reset device on IIC0 bus.

The problem is an I2C Edge Condition which means that I2C devices may
be left in a write state if a read  was  occuring  and  the  CPU  was
reset. This may for example result in EEPROM data corruption.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
(null cookie; hope that's ok)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
