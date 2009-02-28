Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 537C1DDD01
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 02:03:59 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so998871ywb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 07:03:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
References: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
Date: Sat, 28 Feb 2009 08:03:57 -0700
Message-ID: <fa686aa40902280703p5ad8ee73y116d7e2252df21a5@mail.gmail.com>
Subject: Re: PHY not found after migration of gianfar driver to an
	of_platform_driver
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Guntsche <mike@it-loops.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hey Michael,

I just wanted to let you know that I'm reading your questions, and I'm
crafting a reply, but it's not trivial and I'm also swamped under at
the moment.  I should have something for you in the next few days.  I
just didn't want you to think you were being ignored.

g.

On Thu, Feb 26, 2009 at 12:15 PM, Michael Guntsche <mike@it-loops.com> wrot=
e:
> Hello everyone,
>
> I recently obtained a Mikrotik RB600 and applied the patch from
> http://cynigram.com/~nfontes/rb600/=A0to get it up and running with 2.6.2=
8.3
> With this patch applied everything was detected on the board and worked. =
For
> testing purposes I tried a recent git snapshot and noticed that the gianf=
ar
> driver had problems.
> While the the Gianfar was detected
>
> [ =A0 =A00.549115] Gianfar MII Bus: probed
> [ =A0 =A00.553316] eth0 (fsl-gianfar): not using net_device_ops yet
> [ =A0 =A00.560861] eth0: Gianfar Ethernet Controller Version 1.2,
> 00:0c:42:28:de:4e
> [ =A0 =A00.568024] eth0: Running with NAPI enabled
> [ =A0 =A00.572234] eth0: 256/256 RX/TX BD ring size
> [ =A0 =A00.576802] eth1 (fsl-gianfar): not using net_device_ops yet
> [ =A0 =A00.584200] eth1: Gianfar Ethernet Controller Version 1.2,
> 00:0c:42:28:de:4f
> [ =A0 =A00.591345] eth1: Running with NAPI enabled
> [ =A0 =A00.595575] eth1: 256/256 RX/TX BD ring size
>
> trying to up either of the devices gave me
>
> [ =A0 =A08.724818] mdio@24520:01 not found
> [ =A0 =A08.728330] eth1: Could not attach to PHY
> [ =A0 =A08.732945] mdio@24520:01 not found
> [ =A0 =A08.737720] eth1: Could not attach to PHY
>
> I tracked this back to commit "b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4
> gianfar: Convert gianfar to an of_platform_driver". Reverting this one an=
d
> applying for fsc_soc.c made the two nics work again.
> I tried to figure out what was causing the problem in the first place, bu=
t
> failed miserably. I am pretty sure it is just a minor probing issue
> somewhere in the code but I am not able to spot that.
> Maybe someone more knowledgeable than me can take a look at it and help m=
e
> out a little bit.
>
> According to lspci the board is a
>
> 00:00.0 Power PC: Freescale Semiconductor Inc MPC8343 (rev 30)
>
> Please CC me in any replies since I am not subscribed to the ML .. yet.
>
> Thanks in advance,
> Michael
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
