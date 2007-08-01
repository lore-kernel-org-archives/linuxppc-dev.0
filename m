Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 902A6DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 15:41:56 +1000 (EST)
Date: Wed, 1 Aug 2007 07:41:45 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
In-Reply-To: <235e0ff22961e25016727c0e74fd0c0f@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0708010739560.4228@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>
	<87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>
	<Pine.LNX.4.60.0707191932300.3365@poirot.grange>
	<719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>
	<Pine.LNX.4.60.0707202219340.3946@poirot.grange>
	<235e0ff22961e25016727c0e74fd0c0f@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 1 Aug 2007, Segher Boessenkool wrote:

> > > > +		strncpy(info->driver_name, i2c_devices[i].i2c_driver,
> > > > KOBJ_NAME_LEN);
> > > > +		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
> > > 
> > > Why not just strcpy(), btw?
> > 
> > Because target strings are finite length, and sources are just pointers to
> > some constant strings, which one might make arbitrarily long.
> 
> So it's no problem if the name or type string gets cut short?
> Just checking :-)

Then it just won't match. Which is also the expected behaviour, IMHO, if 
someone specifies a name longer than possible maximum length of the 
variable it should match.

Have I passed or failed?:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
