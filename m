Return-Path: <BillF@optiscan.com>
Received: from clinica.optiscan.com (clinica.optiscan.com [203.26.112.14])
	by ozlabs.org (Postfix) with SMTP id A529A67B25
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 09:55:36 +1100 (EST)
Received: from postie.optiscan.com ([203.26.112.10])
	by clinica.optiscan.com (SMSSMTP 4.1.9.35) with SMTP id
	M2006030709403417416
	for <linuxppc-embedded@ozlabs.org>; Tue, 07 Mar 2006 09:40:34 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: INIT:
Date: Tue, 7 Mar 2006 09:40:34 +1100
Message-ID: <34E73CC1202BF246B7DE3463BEBC0689303AEE@postie.optiscan.com>
From: "Bill Farrow" <BillF@optiscan.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
You should find the Virtual Terminal options under "Device Drivers ->
Character Devices" in the kernel configuration.  I don't believe that it
is dependant on anything else, so you should be able to just turn it
off.

Bill

________________________________

From: On Behalf Of Patil, Pankaj P.
Sent: Tuesday, 7 March 2006 4:20 AM
To: Paulinha; linuxppc-embedded@ozlabs.org
Subject: RE: INIT:


I'll look into those config settings. While we are talking about config
settings, i noticed i had CONFIG_VT turned on. I do the make ARCH=3Dppc
xconfig but i cannot find the setting where CONFIG_VT gets turned on. I
don't want to use the virtual terminal & i believe since the kernel is
getting configured with CONFIG_VT=3Dy, it is trying to mount tty0 which =
is
not part of my root file system. Does that make sense??
Is CONFIG_VT dependent on some other config setting?? How do i get
CONFIG_VT set to n??
=20
thanks
pankaj
