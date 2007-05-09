Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id 7C414DDE43
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 May 2007 21:08:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Doing something synchronized with kernel time (HELP!!!)
Date: Wed, 9 May 2007 13:08:45 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E7B8765@aquib01a>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
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

I need to do something every time the number of seconds in the kernel
timer increases. =20
I would like to have something like:
=20
time_t currSecs, currSecs;
=20
while (1)
{   =20
    read(fd, ....);  /* Sleep for 1 second */
=20
    time(&currSecs);  /* I want to be sure that currSecs is=20
                         everytime one unit greater than prevSecs */
    prevSecs =3D currSecs;
}

I tried doing a read on /dev/rtc after having enabled one second
interrupt on RTC (RTC_UIE_ON) but RTC is unreliable (too fast).

Bye,
Antonio.
