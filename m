Date: Tue, 18 Nov 2003 00:42:47 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Wolfgang Denk <wd@denx.de>
Cc: Miku Jha <jha_miku@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc440 and i2c
Message-ID: <20031118084247.GB28129@gate.ebshome.net>
References: <20031118080843.GA28129@gate.ebshome.net> <20031118082248.38F8DC5F59@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031118082248.38F8DC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Nov 18, 2003 at 09:22:43AM +0100, Wolfgang Denk wrote:
>
> > If bootstrap IIC is accidentaly activated you may get problems if you
> > have non-compliant/not-properly-reset device on IIC0 bus.
>
> The problem is an I2C Edge Condition which means that I2C devices may
> be left in a write state if a read  was  occuring  and  the  CPU  was
> reset. This may for example result in EEPROM data corruption.
>

Well, I just read doc from U-Boot, and as far as I understand "I2C
Edge Condition" _cannot_ cause 440 to hang as it was described in the
parent post. Sure, it may cause some unlikely corruption but that's
it (provided we haven't corrupted bootstrap EEPROM itself :).

That's why I suspected some bootstrap IIC interaction with
non-properly-reset i2c device left in some intermediate state (as
show in U-Boot doc for example).

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
