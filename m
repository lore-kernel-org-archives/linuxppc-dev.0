Return-Path: <david.jander@protonic.nl>
From: David Jander <david.jander@protonic.nl>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: MPC5121e, MBX driver, pvr.ko ...
Date: Mon, 16 Feb 2009 09:40:46 +0100
References: <200902060824.06851.david.jander@protonic.nl>
	<20090206191710.C16B78322908@gemini.denx.de>
In-Reply-To: <20090206191710.C16B78322908@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902160940.46783.david.jander@protonic.nl>
Cc: Linuxppc-dev <Linuxppc-dev@ozlabs.org>, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 06 February 2009 20:17:10 Wolfgang Denk wrote:
> Dear David,
>
> In message <200902060824.06851.david.jander@protonic.nl> you wrote:
> > I decided to try out Application Note AN3793 from Freescale (3D Graphics
> > on the ADS512101 Board Using OpenGL ES).
> >
> > I started trying to load the provided (binary!) kernel modules into our
> > kernel, but I am geeting errors inserting the modules using
>
> The binary kernel modules are a mess. Not  only  they  are  a  pretty
> clear  GPL license violation (and I wonder what Freescale is going to
> do to sort this out), but it effectively always locks you down to the

Sorry if this starts to get a little off-topic to this list...
IANAL, so I won't argue about a binary-driver being by definition a 
GPL-violation or not, or if those "gray areas" that Linus mentioned in the 
past, apply in this case.
Besides that, do you have another reason why this is a clear GPL-violation?

> specific LTIB kernel version (and probably even to  a  specific  DTS)
> they were built against. Open source? Forget it.

I never expected this driver to be Open-Source. I always supposed that we'd 
never be able to use the MBX because of this, and use the AXE instead (One of 
our applications needs some form of hardware accelerated image-scaling). But 
since I saw that application note, I couldn't resist trying it out, just to 
see how hard it is to actually use it. The point is made: Leaving aside the 
possible legal implications of the driver's existance, it still is an 
undoable job to get this working in a maintainable fashion.
What could Freescale possibly do about this?... beats me. I don't know about 
the legal implications (again, IANAL), but what if there was a driver like 
NVidia's video drivers (i.e. binary object with a re-compileable shell around 
it to adapt it to other kernels)? Otherwise, I guess Freescale can just as 
well stop making the MPC5121e and just make MPC5123's instead (which 
continues to be an awesome chip nevertheless) :-)

Best regards,

-- 
David Jander
Protonic Holland.
