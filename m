Return-Path: <Josef.Angermeier@informatik.uni-erlangen.de>
Received: from max71.rrze.uni-erlangen.de (max71.rrze.uni-erlangen.de
	[131.188.3.181]) by ozlabs.org (Postfix) with ESMTP id A2CCD67B6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 20:40:06 +1000 (EST)
Received: from max71.rrze.uni-erlangen.de (max71.rrze.uni-erlangen.de
	[131.188.3.181]) by max71.rrze.uni-erlangen.de with ESMTP for
	linuxppc-embedded@ozlabs.org; Fri, 11 Aug 2006 12:39:52 +0200
Received: from max71.rrze.uni-erlangen.de ([131.188.3.181])
	by max71.rrze.uni-erlangen.de (max71.rrze.uni-erlangen.de [127.0.0.1])
	(amavisd-new)
	with ESMTP id 11787-08-10 for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 12:39:52 +0200 (MEST)
Received: from [131.188.51.43] ([131.188.51.43] [131.188.51.43]) by
	mailhub.rrze.uni-erlangen.de with ESMTP for
	linuxppc-embedded@ozlabs.org; Fri, 11 Aug 2006 12:39:52 +0200
Message-Id: <44DC5E7A.4010907@cs.fau.de>
Date: Fri, 11 Aug 2006 12:39:54 +0200
From: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: mpc8xx usb controller on linux 2.6
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

Hello,

I am using linux 2.6.18 on a MPC875, which runs on a custom board. Some changes to the official kernel allow me to get the mpc8xx internal usb host controller working and access an usb stick successfully. I just used Brad Parkers 2.4 patch, ported it to linux 2.6 and merged
it with the cpm2usb project. Until now it just worked for my board. Maybe any skilled programmer would like to test the patch also on his own board, fix some bugs and give me some confidence that the patch is somehow stable so that it once can be added to official linux source tree. I would appreciate that and try to help to get it working.

You can find the patch at

http://wwwcip.informatik.uni-erlangen.de/~sijoange/

Because of a bug in the m8xx USB CPM (read m8xx errata) you must feed a 1khz signal out and feed it at the DREQ pin in again on your board. Then you have to patch the kernel, configure linux to use the m8xx usb sof patch and the m8xx usb host controller, startup the compiled linux, fix some bugs, give me some feedback. 

Regards,
Josef
