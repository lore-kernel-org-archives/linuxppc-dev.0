Return-Path: <Kari.Davidsson@marel.com>
Received: from mail.marel.is (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 377E6B7B76
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 22:36:09 +1100 (EST)
Message-ID: <4AD70927.3030401@marel.com>
Date: Thu, 15 Oct 2009 11:36:07 +0000
From: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
MIME-Version: 1.0
To: "paul.gibson2074@gmail.com" <paul.gibson2074@gmail.com>
Subject: Re: MPC5121 CAN and USB
References: <4AD5ADC9.30503@embedded-sol.com>
	<4AD6F172.6030407@aimvalley.nl>	<4AD6FD4E.9060507@marel.com>
	<4AD70585.40302@gmail.com>
In-Reply-To: <4AD70585.40302@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you Paul,

The kernel from the BSP on Freescale site is crashing on the CAN in my case=
 (might be a hardware bug).
I could not find the source for the kernel in the BSP or on the freescale s=
ite.

I had not looked at http://git.denx.de/?p=3Dlinux-2.6-denx.git;a=3Dshortlog=
;h=3Drefs/heads/ltib-mpc5121ads-20090602

I am now in the progress of cloning the linux-mpc512x git from denx and bui=
lding from it.
Hopefully that will help me.

rg
kd

Paul Gibson wrote:
> In my opinion the best place is the BSP available on the MPC5121e page=20
> on the Freescale site.
>=20
> I actually use the kernel in the git repository here which is similar to=
=20
> the BSP:
> http://git.denx.de/?p=3Dlinux-2.6-denx.git;a=3Dshortlog;h=3Drefs/heads/lt=
ib-mpc5121ads-20090602=20
> or here:
> http://git.denx.de/?p=3Dlinux-mpc512x.git;a=3Dsummary
>=20
> I have found both to be very stable, also with the CAN and USB.
>=20
> Paul
>=20
> K=E1ri Dav=ED=F0sson wrote:
>> Hello,
>>
>> Where is the most current linux work for the Freescale MPC5121 cpu=20
>> stored.
>> What I am specifically interested in at this time is the CAN and USB=20
>> subsystems.
>>
>> rg
>> kd
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
