Return-Path: <awilliam@nortel.com>
Received: from zrtps0kn.nortelnetworks.com (zrtps0kn.nortelnetworks.com
	[47.140.192.55]) by ozlabs.org (Postfix) with ESMTP id 83AF968045
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Aug 2005 01:30:11 +1000 (EST)
Received: from zcarhxm2.corp.nortel.com (zcarhxm2.corp.nortel.com
	[47.129.230.99])
	by zrtps0kn.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP
	id j7PFJXm01008 for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 11:19:34 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 25 Aug 2005 11:19:31 -0400
Message-ID: <713043CE8B8E1348AF3C546DBE02C1B4049162C5@zcarhxm2.corp.nortel.com>
From: "Andrew Williams" <awilliam@nortel.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: COP Status 0x21
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<insert favorite curses here>

  Spend 6 hours searching, draft an email to the list, and solve=20
problem 20 minutes later. Compared my BDI to a co-workers and=20
and discovered that although we had the same firmware, we didn't have=20
the same "Logic" version in the device. Reflashed and I can=20
now read the PVR correctly.

  Sorry to waste everyone's time on this.

Andrew

  =20

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> Williams, Andrew [CAR:9D30:EXCH]
> Sent: August 25, 2005 10:38 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: COP Status 0x21
>=20
>=20
> Hello List..
>   (hope this is considered "on" topic)
>=20
>    Situation: New hardware (mcp8347)
>               BDI connected, but unable to read PVR
>               Prior to the READ I see a "COP status is 0x21"
>        =20
>    Q. What does a status of 0x21 mean?=20
>=20
>    Q. I've searched online for some type of a reference to the=20
>       COP interface to no avail. Can anyone direct me to=20
>       a technical reference?=20
>=20
>=20
> Thanks,
> Andrew
>=20
> -- BDI Config [TARGET] section --
> [TARGET]
> CPUTYPE     8349                        ;the CPU type
> JTAGCLOCK   0                           ;use 16 MHz JTAG clock
> BOOTADDR    0xfff00100                  ;boot address used=20
> for start-up
> break
> POWERUP     2000                        ;start delay after power-up
> detected in ms
> WAKEUP      800                         ;give reset time to complete
> STARTUP     RESET                       ;halt immediatelly at the boot
> vector
> BREAKMODE   HARD                        ;SOFT or HARD, HARD uses PPC
> hardware breakpoint
> STEPMODE    HWBP                        ;TRACE or HWBP, HWBP uses a
> hardware breakpoint
>=20
>=20
> -- BDI Debug Output --
> - TARGET: waiting for target Vcc
> - TARGET: processing power-up delay
> - TARGET: processing user reset request
> - BDI asserts HRESET
> - Reset JTAG controller passed
> - Bypass check: 0x00000001 =3D> 0x00000001
> - Bypass check: 0x00000001 =3D> 0x00000001
> - JTAG exists check passed
> - COP status is 0x21
> - Check running state passed
> - BDI scans COP freeze command
> - BDI removes HRESET
> - Target PVR is 0x00000000
> - This PVR is not supported
> - TARGET: Target PVR is 0x00000000
> *** TARGET: resetting target failed
> # PPC: This target is not supported
> - TARGET: target will be restarted in 10 sec=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org=20
> https://ozlabs.org/mailman/listinfo/linuxppc-> embedded
>=20
>=20
