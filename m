Return-Path: <tmike@theptrgroup.com>
Received: from harrier.mail.pas.earthlink.net (harrier.mail.pas.earthlink.net
	[207.217.120.12]) by ozlabs.org (Postfix) with ESMTP id 6F1A92BC0F
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Sep 2004 03:02:29 +1000 (EST)
Received: from dpc6682041083.direcpc.com ([66.82.41.83] helo=tmtwin2kpro)
	by harrier.mail.pas.earthlink.net with smtp (Exim 3.33 #1)
	id 1CChqQ-0006Qu-00
	for linuxppc-dev@ozlabs.org; Wed, 29 Sep 2004 10:02:25 -0700
From: "T Michael Turney" <tmike@theptrgroup.com>
To: <linuxppc-dev@ozlabs.org>
Date: Wed, 29 Sep 2004 10:08:53 -0700
Message-ID: <GEEKLLHMFHLAJOBEEELHAEOECLAA.tmike@theptrgroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: General configuration query
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Folks,
This is a bit of a follow-on from a 405
query from last week.

I have a working 2.4.22 ppc/405 system
with an initrd (busybox) serving as the
root filesystem.

We have to add IDE support and Network
support, but don't have working drivers for
these devices.  The onchip ethernet is
not directly connected to a PHY but to
a HUB chip so this driver requires a little tweaking.

In an effort to test the stability of our
baseline I enabled Network Support (CONFIG_NET)
but didn't turn on any networking options or
enable any devices.

The image built but almost immediately OOPS.

Is this expected behavior or does this point
to instability in my baseline?

[If this query belongs on the other 'new' list,
my apologies, I'm still finding my way.]
Cheers,
T.mike
