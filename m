Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 7369C2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Dec 2004 20:37:23 +1100 (EST)
Message-ID: <1102586055.41b820c776f7f@webmail.televes.com:443>
Date: Thu,  9 Dec 2004 10:54:15 +0100
From: alebas@televes.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: CONFIG_DUMMY_CONSOLE question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

Checking console initialization on mpc8272ads board,
I have seen that the CONFIG_DUMMY_CONSOLE config
parameter is allways set in root .config file, regardless
of its value on my arch/ppc/configs/ads8272_defconfig file.

This parameter drives to the VGA dummy console being
compiled and included in the vmlinux binary, and started
as default console for the board (which must be changed
with console boot arg).

Does anyone knows if this parameter is a must in any kernel
2.6 configuration? And why? Can it be removed, as my board
doesn't use VGA at all? How? (I have tried several options)

Thanks,

Alex
