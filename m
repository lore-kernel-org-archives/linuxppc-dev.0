Subject: Re: R128 Scaling.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Stefan Berndtsson <stefan@nocrew.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.BSF.4.44.0204162241110.49666-100000@shell.unixbox.com>
References: <Pine.BSF.4.44.0204162241110.49666-100000@shell.unixbox.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 17 Apr 2002 13:54:56 +0200
Message-Id: <1019044496.1617.448.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2002-04-17 at 07:44, Ani Joshi wrote:
>
> On 16 Apr 2002, Michel [ISO-8859-1] Dänzer wrote:
>
> > Is that with a driver with optimized ImageWrite acceleration? I don't
> > think any stock XFree86 driver is really optimized there yet, I'm
> > working on radeon now and the results should be easily applicable to
> > r128.
>
> There are several that do ImageWrie acceleration.  The radeon driver already
> does indirect ImageWrite acceleration (its the same as CPUToScreen color
> expansion).

Which is slower than memcpy for a simple upload. I'm finishing a CP based
implementation which is significantly faster, at least in 16 bit.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
