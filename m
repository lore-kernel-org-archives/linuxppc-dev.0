Return-Path: <tsawyer@broadcom.com>
Message-ID: <44BF9FBA.8030201@broadcom.com>
Date: Thu, 20 Jul 2006 11:22:34 -0400
From: "Travis B. Sawyer" <tsawyer@broadcom.com>
MIME-Version: 1.0
To: bwarren@qstreams.com
Subject: Re: I2C with bus muxes
References: <1153408592.19682.39.camel@saruman.qstreams.net>
In-Reply-To: <1153408592.19682.39.camel@saruman.qstreams.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Ben Warren wrote:
> Hello,
>
> Has anyone implemented devices like the Philips PCA954x I2C bus muxes
> under the /sysfs device model?  I have some optical transponders on my
> board that through the wisdom of some committee all have the same fixed
> I2C address.  To get around this, we put them behind muxes, creating
> 'virtual' I2C busses.  I imagine this could be modeled something like
> the USB hub model, but that's just a first stab.
>
>   
Ben:

I have a driver for 2.4.x that works with our SFP/XFPs.  We also have a 
bunch of other 'stuff'
hanging off of muxes.  I haven't given it a go on 2.6, but I have it 
compiled and it doesn't complain on
startup.

Not sure if I should send it here, as it won't be in patch form...

Lemme know if you want a look-see,

Travis
