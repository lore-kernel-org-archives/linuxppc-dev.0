Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 44FE267C39
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jul 2005 01:29:29 +1000 (EST)
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1121738905.14393.43.camel@gaston>
References: <1121718331.2400.24.camel@cashmere.sps.mot.com>
	<1121738905.14393.43.camel@gaston>
Content-Type: text/plain
Message-Id: <1121786960.9738.6.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 19 Jul 2005 10:29:20 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: DTC memory reserve question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-07-18 at 21:08, Benjamin Herrenschmidt wrote:

> > Naturally, that yields System.map entries like this:
> > 
> > c0013988 t _dt_blob_start
> > c0013988 T dt_blob_start
> > c0013988 t _dt_header
> > c0013988 T dt_header
> > c00139b0 t _dt_reserve_map
> > c00139b0 T dt_reserve_map
> > c00139d0 t _dt_struct_start
> > c00139d0 T dt_struct_start
> > c0013df0 t _dt_strings_start
> > c0013df0 T dt_strings_start
> > c0013df0 t _dt_struct_end
> > c0013df0 T dt_struct_end
> > c0013f05 t _dt_blob_end
> > c0013f05 T dt_blob_end
> > 
> > Notice that these are 0xC-gazillion addresses.
> 
> How are you getting these addresses ? You are trying to link the output
> of dtc with the kernel directly ?

Yep.  I'm in testing mode, and wanted a QAD way to get my
initial DTC blob to the code without having to first do
wild U-Boot hackery, or downloading or flash burning or
any number of other annoying solutions. :-)

So I am not handing off r3 pointing to the blob yet.
It's just a data array assembled and linked into the kernel.
Later, when things work better, it will be r3'ed in as
per the spec, of course.

>  Hrm...  That will not work

Oddly, that is what I noticed too! :-)

>  for that
> (and maybe a couple of other things). Might be better to link it with
> the zImage wrapper...

Well, I need to u-boot this kernel into running...

Thanks,
jdl
