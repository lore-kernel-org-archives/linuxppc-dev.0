Date: Tue, 16 Apr 2002 22:44:49 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Stefan Berndtsson <stefan@nocrew.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: R128 Scaling.
In-Reply-To: <1018964431.1590.2722.camel@tibook>
Message-ID: <Pine.BSF.4.44.0204162241110.49666-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 16 Apr 2002, Michel [ISO-8859-1] Dänzer wrote:

> Is that with a driver with optimized ImageWrite acceleration? I don't
> think any stock XFree86 driver is really optimized there yet, I'm
> working on radeon now and the results should be easily applicable to
> r128.


There are several that do ImageWrie acceleration.  The radeon driver already
does indirect ImageWrite acceleration (its the same as CPUToScreen color
expansion).  There are others which do it in the direct method, the savage
driver is an example.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
