Subject: Re: [PATCH] ugly hack to make therm_pm72 work on XServe G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040806080406.GB11638@sunbeam2>
References: <20040805114348.GD7112@sunbeam2>
	 <20040806080406.GB11638@sunbeam2>
Content-Type: text/plain
Message-Id: <1091779753.9271.220.camel@gaston>
Mime-Version: 1.0
Date: Fri, 06 Aug 2004 18:09:14 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-08-06 at 18:04, Harald Welte wrote:
> I actually forgot that small userspace program ;)
>
> It is a total ripoff of the kernel driver and was implemented because
> it's easier to play with i2c from userspace during development.
>
> benh:  Any reason why you implemented your own byte+word read/write
> routines?  Apparently the i2c_smbus routines work quite fine, even from
> userspace...

I don't remember the exact reason, I had some issues, either with the
sensors or the FCU, or maybe it was for mimmicing OF code...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
