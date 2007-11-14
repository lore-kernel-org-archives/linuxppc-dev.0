Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id B0BF0DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 07:23:31 +1100 (EST)
Message-ID: <473B5940.2090306@anagramm.de>
Date: Wed, 14 Nov 2007 21:23:28 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: robert lazarski <robertlazarski@gmail.com>
Subject: Re: 85xx Device tree problems: e0024520:02 not found
References: <f87675ee0711131217q6bb54e06q74f7d16e79b94f19@mail.gmail.com>	<473A0A1B.3020302@anagramm.de>
	<f87675ee0711141118h3281b79dpaa49c6da7d57d891@mail.gmail.com>
In-Reply-To: <f87675ee0711141118h3281b79dpaa49c6da7d57d891@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

robert lazarski schrieb:
 > I'm now running pauilis.git and 2.6.24rc2, along with a new custom
 > board. I still can't attach to the phy though. I know the phy works
 > because it works fine in u-boot. Clemens, IIRC you are using the
 > 88e1111 - is that with the gianfar driver?

Yes, yes.

(I still have to check my PHY addresses.)

 > I'm having problems getting
 > soft reboot to work with paulus.git from some reason so debugging is
 > slow going - might someone have some hints?

I can also ACK your reboot-problem.
$ shutdown -r now
stops here at:
Restarting system.

IIRC, there were some patches some time ago changing some powerpc
reboot stuff...

Propably, git-bisect will be our friend.
The latest working kernel over here was:
Linux-2.6.21-rc5-g9a5ee4cc with ARCH=ppc
I think it was also from paulus.

Now I am at ARCH=powerpc.

Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
