Return-Path: <shubhada@chelsio.com>
Received: from stargate.chelsio.com (stargate.chelsio.com [12.22.49.110])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90FF3DDDE0
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 07:21:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: AMCC ppc440spe 2.6.23.10 kernel boot help
Date: Thu, 12 Feb 2009 12:21:26 -0800
Message-ID: <8A71B368A89016469F72CD08050AD33402D57549@maui.asicdesigners.com>
From: "Shubhada Pugaonkar" <shubhada@chelsio.com>
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfgang

I could get 2.6.28 version up and running after using device tree blob.
Also our customer is using Luan and our IT dept ordered Katmai.=20

So looks like the problem is solved for now (basically my company needs
to look into alternative setups)

Thanks a lot for your prompt help.
Shubhada

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]=20
Sent: Thursday, February 12, 2009 12:07 AM
To: Shubhada Pugaonkar
Cc: linuxppc-dev@ozlabs.org
Subject: Re: AMCC ppc440spe 2.6.23.10 kernel boot help

Dear Shubhada,

In message
<8A71B368A89016469F72CD08050AD33402D57545@maui.asicdesigners.com> you
wrote:
>=20
> I am kind of helpless regarding the kernel version, as our customer is
> using it and I need to replicate their environment. I just tried
2.6.28
> with katmai_defconfig file and still face the same problem.=20

You probably did not load (and use) the device tree blob which is
needed with recent (arch/powerpc based) kernel versions.

> The config file that I sent before is provided by the customer. It is
a
> working configuration for them.=20
>=20
> The exact board that I have is Katmai.

It looks broken to me for a Katmai board. Are you sure your customer
is also using Katmai?

> my printenv output is as follows.

This is obviously  an  old  setup  for  old  (arch/ppc  only)  kernel
versions,  and  heavily  crippl^H^H^H^H^H  modified  from the default
environment.  You  might  consider  to  restart  from   the   default
environment settings (probably even with a recent version of U-Boot -
your's is too old and does not include full device tree support).

On the other hand, I don;t see a reason why the old (arch/ppc based)
kernel should not boot - except that it might be misconfigured for
that board.

Did you try any of the released (and well tested) kernel images on
our FTP server? See ftp://ftp.denx.de/pub/linux/images/amcc/katmai/

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Just think of a computer as hardware you can program."
- Nigel de la Tierre
