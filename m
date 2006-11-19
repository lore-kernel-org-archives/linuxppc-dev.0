Return-Path: <leisun124@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.235])
	by ozlabs.org (Postfix) with ESMTP id 94F5567C00
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 08:21:21 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so1504771wxd
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 19 Nov 2006 13:21:19 -0800 (PST)
Message-ID: <f9a7e7a80611191321r291964cfh653a88714b3b0267@mail.gmail.com>
Date: Sun, 19 Nov 2006 16:21:19 -0500
From: "Lei Sun" <leisun124@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: BDI2000 not processing init list
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all:
   I got BDI2000 today, tring to use to to debug my MMU problem. But
after I hooked it up and issue "reset", the following messages are
printed out:

BDI>reset
- BDI asserts HRESET
- Reset JTAG controller passed
- Bypass check: 0x00000001 => 0x00000001
- JTAG exists check passed
- COP status is 0x01
- Check running state passed
- BDI scans COP freeze command
- BDI removes HRESET
- Target PVR is 0x80822013
- Target SVR is 0x00000000
- COP status is 0x05
- Check stopped state passed
- Check LSRL length passed
- BDI sets breakpoint at 0xFFF00100
- BDI resumes program execution
- Waiting for target stop passed

It didn't process the init list, the IMMR still shows the default
value, instead of the one specified in init list.  The weird thing is
, if it didn't process init list, it should keep resetting because of
the watch dog timmer, I didn't see that happen as well.

My target is mpc8270, the BDI firmware version is 1.24 logic 1.05

Any one had the similar experience ?

Thanks
lei
