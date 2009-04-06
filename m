Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 132E2DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 08:20:25 +1000 (EST)
Date: Mon, 6 Apr 2009 18:20:23 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Hotplug on PPC4xx
Message-ID: <20090406182023.0729073a@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am trying to run the /sbin/hotplug from the kernel and it doesn't
work. Has anybody got it running?

I know I am being a bit vague, but I don't want to write a long email
and find out that it is a know problem ;)

Basically, I want to automount SD cards and USB keys. So if anybody
knows a better way than hotplug, let me know. I would rather not have
to setup udev/hald/dbus.

Cheers,
   Sean
