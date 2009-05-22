Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <4A143896.7050200@grandegger.com>
References: <4A143896.7050200@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 21 May 2009 22:42:07 -0600
Message-ID: <fa686aa40905212142n4a8c3caamb2f28eef036e3922@mail.gmail.com>
Subject: Re: [net-next-2.6 PATCH] can: SJA1000: generic OF platform bus driver
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux Netdev List <netdev@vger.kernel.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 20, 2009 at 11:06 AM, Wolfgang Grandegger <wg@grandegger.com> w=
rote:
> This patch adds a generic driver for SJA1000 chips on the OpenFirmware
> platform bus found on embedded PowerPC systems. You need a SJA1000 node
> definition in your flattened device tree source (DTS) file similar to:
>
> =A0 can@3,100 {
> =A0 =A0 =A0 =A0 =A0 compatible =3D "philips,sja1000";
> =A0 =A0 =A0 =A0 =A0 reg =3D <3 0x100 0x80>;
> =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <8000000>;
> =A0 =A0 =A0 =A0 =A0 cdr-reg =3D <0x48>;
> =A0 =A0 =A0 =A0 =A0 ocr-reg =3D <0x0a>;
> =A0 =A0 =A0 =A0 =A0 interrupts =3D <2 0>;
> =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&mpic>;
> =A0 };

This new binding must be documented in Documentation/powerpc/dts-bindings

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
