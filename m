Return-Path: <B04825@freescale.com>
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Aggrwal Poonam-B10812 <B10812@freescale.com>
Subject: Re: [PATCH] Device Tree Bindings for Freescale TDM controller
Date: Sat, 17 Mar 2012 16:07:29 +0000
Message-ID: <CAOZdJXVU=1bW8_OTMecJHuWaa6_023UnUsfQTX8MGqd3E4SRAg@mail.gmail.com>
References: <1331861451-15427-1-git-send-email-poonam.aggrwal@freescale.com>
 <4F63868D.1030507@freescale.com>
 <ACB6D0C0104CFF42A45A5D82A0DD4F3D09D518@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <ACB6D0C0104CFF42A45A5D82A0DD4F3D09D518@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 17, 2012 at 2:33 AM, Aggrwal Poonam-B10812
<B10812@freescale.com> wrote:
>
>> > + =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,p1010-tdm", "fsl,mpc8315-tdm=
";
>> > + =A0 =A0 =A0 =A0 =A0 reg =3D <0x16000 0x200 0x2c000 0x2000>;
>> > + =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <0>;
>>
>> Show a real clock-frequency, perhaps with a comment saying it's typicall=
y
>> filled in by boot software.

> Okay.

Scott, are you suggesting that Poonam put a non-zero number in the DTS
for clock-frequency?  If so, then I don't think that's a good idea, if
U-Boot will always override it.

--=20
Timur Tabi
Linux kernel developer at Freescale=
