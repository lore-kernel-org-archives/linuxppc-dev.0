Return-Path: <awilliam@nortel.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id 7B43A68139
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Aug 2005 00:45:14 +1000 (EST)
Received: from zcarhxm2.corp.nortel.com (zcarhxm2.corp.nortel.com
	[47.129.230.99])
	by zcars04f.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP
	id j7PEcJE15429 for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Aug 2005 10:38:19 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 25 Aug 2005 10:38:17 -0400
Message-ID: <713043CE8B8E1348AF3C546DBE02C1B4049161C0@zcarhxm2.corp.nortel.com>
From: "Andrew Williams" <awilliam@nortel.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: COP Status 0x21
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello List..
  (hope this is considered "on" topic)

   Situation: New hardware (mcp8347)
              BDI connected, but unable to read PVR
              Prior to the READ I see a "COP status is 0x21"
       =20
   Q. What does a status of 0x21 mean?=20

   Q. I've searched online for some type of a reference to the=20
      COP interface to no avail. Can anyone direct me to=20
      a technical reference?=20


Thanks,
Andrew

-- BDI Config [TARGET] section --
[TARGET]
CPUTYPE     8349                        ;the CPU type
JTAGCLOCK   0                           ;use 16 MHz JTAG clock
BOOTADDR    0xfff00100                  ;boot address used for start-up
break
POWERUP     2000                        ;start delay after power-up
detected in ms
WAKEUP      800                         ;give reset time to complete
STARTUP     RESET                       ;halt immediatelly at the boot
vector
BREAKMODE   HARD                        ;SOFT or HARD, HARD uses PPC
hardware breakpoint
STEPMODE    HWBP                        ;TRACE or HWBP, HWBP uses a
hardware breakpoint


-- BDI Debug Output --
- TARGET: waiting for target Vcc
- TARGET: processing power-up delay
- TARGET: processing user reset request
- BDI asserts HRESET
- Reset JTAG controller passed
- Bypass check: 0x00000001 =3D> 0x00000001
- Bypass check: 0x00000001 =3D> 0x00000001
- JTAG exists check passed
- COP status is 0x21
- Check running state passed
- BDI scans COP freeze command
- BDI removes HRESET
- Target PVR is 0x00000000
- This PVR is not supported
- TARGET: Target PVR is 0x00000000
*** TARGET: resetting target failed
# PPC: This target is not supported
- TARGET: target will be restarted in 10 sec
