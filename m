Return-Path: <Atit_Shah@satyam.com>
Received: from VVAMAIL1.satyam.com (vvamail1.satyam.com [208.220.247.18])
	by ozlabs.org (Postfix) with ESMTP id 87F80679F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 19:40:49 +1000 (EST)
Received: from VVAMAIL1.satyam.com (us.satyam.com [127.0.0.1])
	by us.satyam.com (8.11.2/8.11.2) with ESMTP id j4H9XiE32498
	for <linuxppc-embedded@ozlabs.org>; Tue, 17 May 2005 05:33:44 -0400
Received: from Disclaimerbng.corp.satyam.ad
	(IDENT:sDyAvJtYFDtXpR+uJalZTD6s4pk2igax@localhost [127.0.0.1])
	by blr.satyam.com (8.11.6/8.11.6) with ESMTP id j4H9Tqv26427
	for <linuxppc-embedded@ozlabs.org>; Tue, 17 May 2005 14:59:52 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 17 May 2005 15:05:37 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED10277CE@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Starting UDHCP server at startup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,
	I wish to start the udhcp server at boot up through the start up
script. I create a file S47udhcpd in /etc/init.d/ with the following
contents:

#!/bin/sh

PKG=3D"udhcp server"
STARTCMD=3D"/usr/sbin/udhcpd"
STOPCMD=3D"killall udhcpd"

. /etc/init.d/common

This is the last commond to be executed ie just before the linux prompt
ask for the login and password.

When I boot the system I get the following error message "SIOCGIFADDR
failed, is the interface up and configured?: Cannot assign requested
address."

If I give the command "udhcpd" in my /etc/profile file the server
starts. Why does this happen?=20

If I am having this for a router I will need to run udhcpd the moment it
comes...how will I do this?

Regards
Atit


DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
