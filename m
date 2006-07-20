Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <1153408592.19682.39.camel@saruman.qstreams.net>
References: <1153408592.19682.39.camel@saruman.qstreams.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <61F75343-B9B9-4349-A463-E39C7532A378@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: I2C with bus muxes
Date: Thu, 20 Jul 2006 13:51:53 -0500
To: bwarren@qstreams.com
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 20, 2006, at 10:16 AM, Ben Warren wrote:

> Hello,
>
> Has anyone implemented devices like the Philips PCA954x I2C bus muxes
> under the /sysfs device model?  I have some optical transponders on my
> board that through the wisdom of some committee all have the same  
> fixed
> I2C address.  To get around this, we put them behind muxes, creating
> 'virtual' I2C busses.  I imagine this could be modeled something like
> the USB hub model, but that's just a first stab.

I'm pretty sure I submitted a set of patches for this upstream.   
However there was some desire to hold off until some other changes.

http://marc.theaimsgroup.com/?l=linux-kernel&m=114376108231285&w=2
http://marc.theaimsgroup.com/?t=114316214100001&r=1&w=2

- kumar
