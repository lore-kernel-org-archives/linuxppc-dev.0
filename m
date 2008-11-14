Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6A68DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 16:27:34 +1100 (EST)
Date: Fri, 14 Nov 2008 08:27:25 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <919499964.20081114082725@emcraft.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re[2]: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
In-Reply-To: <20081114050001.GA15181@secretlab.ca>
References: <200811131149.14715.yur@emcraft.com>
	<20081113064533.77eccc1b@zod.rchland.ibm.com>
	<20081114050001.GA15181@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=0D=0AHello Grant,

On Friday, November 14, 2008 you wrote:

> On Thu, Nov 13, 2008 at 06:45:33AM -0500, Josh Boyer wrote:
>> On Thu, 13 Nov 2008 11:49:14 +0300
>> Yuri Tikhonov <yur@emcraft.com> wrote:
>> > +           sysacecf@4fe000000 {
>> > +                   compatible =3D "xlnx,opb-sysace-1.00.b";
>>=20
>> Odd.  This isn't a xilinx board by any means.  This should probably
>> look something like:
>>=20
>>       compatible =3D "amcc,sysace-440spe", "xlnx,opb-sysace-1.00.b";

> Actually, if there is a sysace, it is definitely a xilinx part.  It
> won't be on the SoC.  However, compatible =3D "xlnx,opb-sysace-1.00.b"
> isn't really accurate.  It should really be compatible =3D "xlnx,sysace"
> and the driver modified to accept this string.

 OK, we'll do this, and then re-post together with the cleaned-up=20
"[PATCH] xsysace: use resource_size_t instead of unsigned long" patch.


>   "xlnx,opb-sysace-1.00.b"
> is an FPGA block used to interface to the system ace which is
> definitely not in use here.

> So while it does get things to work, it is not a clean description of
> the hardware.

> g.




 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
