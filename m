Message-ID: <762A181C0D966E459A2EB3B810142C77038612FC@nmrusdunsx12.nmrlan.net>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: "'Thamarai Selvan'" <Thamarai.Selvan@lntinfotech.com>,
	linuxppc-embedded@lists.linuxppc.org
Cc: uclinux-dev@uclinux.org
Subject: RE: Need clarity on compiler & emulator usage
Date: Mon, 1 Mar 2004 09:01:35 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thamarai Selvan wrote:

>can we use vision ice emulators to download the image if not why?

I realized I didn't answer this question in my last response.  The
short answer is yes.  visionICE will download a Linux image just fine.

I successfully ported Linux to our custom MPC850 hardware and I used
visionICE/visionEVENT/visionCLICK to do it.  The problem arises when
the startup code turns the MMU on.  At that point, the visionICE/
visionCLICK combination becomes useless.  Further, there is no support
for either kernel or user-land debugging once Linux is up and running.

Note that our visionICE hardware and visionCLICK software is a couple
of years old and WRS may have added some Linux support since that time.

I'd still like to have a BDI2000.

Regards,
Charlie

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
