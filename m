Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 56BEADDF3E
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 08:40:18 +1100 (EST)
Received: from [192.168.1.37] (66-81-70-74.bayarea.dialup.o1.com [66.81.70.74])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id mA7Ld9Xk014630
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Nov 2008 13:40:13 -0800 (PST)
Message-ID: <4914B549.9010805@hypersurf.com>
Date: Fri, 07 Nov 2008 13:38:17 -0800
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: pmac_zilog debugging ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

	If I use a command similar to:

pppd ttyS0 1200 satellites: netmask 255.255.255.0 lock crtscts mru 1064 noauth debug kdebug 7 
logfile /tmp/pppd.log local

to connect an 8600 to a laptop via ppp the link will lock up in short
order from "payloaded" pings. Any advice on how to figure out where it
is locking up? This command works fine to connect two x86 laptops. At
1200 it does take a while for an xterm to show up, though.

kevin
