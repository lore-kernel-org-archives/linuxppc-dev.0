Subject: Re: tas: I2C byte write failed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <m3he4r8cfs.fsf@whitebox.as.local>
References: <m3he4r8cfs.fsf@whitebox.as.local>
Content-Type: text/plain
Message-Id: <1060419278.653.13.camel@gaston>
Mime-Version: 1.0
Date: 09 Aug 2003 10:54:38 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2003-08-09 at 10:25, Andreas Schwab wrote:
> Whenever my iBook wakes up I get the message "tas: I2C byte write
> failed" and sound remains silent.  This is with 2.4.21-ben2 (TAS3004
> driver V 0.3), but happens with previous versions as well.  Could this
> be a problem of wrong reinitialisation order during wakeup (both
> dmasound and i2c are compiled as module)?  Resetting the volume makes
> sound work again.

Might be, I'll investigate. Thanks.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
