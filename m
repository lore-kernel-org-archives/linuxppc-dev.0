Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 4 Jun 2003 09:51:38 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: linuxppc-embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Failsafe bootloader
Message-ID: <3EE8E5EA@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
We use small part of our flash to hold config data (last sector of the flash)
and which image must be started. PPCBoot read this and start the right image.
when upgrading , we change the kernel option to the failsafe kernel, do the
update of the second kernel (the working one) and after that we change the
kernel option again and we try to start the new one. We use also a kind of
watchdog feature in case of system lockout.

Benoit Callebaut
Barco NV
www.barco.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
