Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id D0444DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 00:23:04 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so1492804ywe.39
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 06:23:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49D1E3E5.3080607@grandegger.com>
References: <49C26434.30302@grandegger.com>
	<fa686aa40903192205yed7eb13t45db80a201549f0d@mail.gmail.com>
	<49D1E3E5.3080607@grandegger.com>
Date: Tue, 31 Mar 2009 07:23:02 -0600
Message-ID: <fa686aa40903310623r2b2db0adjb912cfefd3a321e2@mail.gmail.com>
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
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

On Tue, Mar 31, 2009 at 3:35 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> Grant Likely wrote:
>> I agree 100% with David's comments, and I have some additional ones belo=
w.
>>
>> On Thu, Mar 19, 2009 at 9:26 AM, Wolfgang Grandegger <wg@grandegger.com>=
 wrote:
>>> + =A0 =A0 =A0 soc8544@e0000000 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "soc";
>>
>> Drop device_type here too.
>
> Grrr, I just realized that removing the devices type "soc" has broken
> fsl_get_sys_freq(). See:
>
> http://lxr.linux.no/linux+v2.6.29/arch/powerpc/sysdev/fsl_soc.c#L80
>
> We need a quick fix and we could take the occasion to establish a common
> function for the MPC52xx as well, but it's not obvious to me how to find
> the SOC node without the device type property.

SoC node should have a compatible property, just like everything else.

compatible =3D "fsl,mpc8544-immr";  (immr =3D=3D Internally Memory Mapped R=
egisters)

Many other boards already do this.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
