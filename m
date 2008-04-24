Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 9E6BFDDF45
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 07:25:06 +1000 (EST)
Received: from [192.168.1.37] (node10.75.251.72.1dial.com [72.251.75.10])
	(authenticated bits=0)
	by smtpauth.hypersurf.com (8.14.2/8.14.2) with ESMTP id m3OLHgnS096810
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 14:19:18 -0700 (PDT)
Message-ID: <48110426.1030400@hypersurf.com>
Date: Thu, 24 Apr 2008 15:05:26 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: sysfs cpu entry
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

	Can someone suggest where to add the code for a cpu 
(/sys/devices/system/cpu/cpu0) entry in sysfs?

	The 2.6.24 release has a sysfs.c file but it only seems to be used for 
64-bit? Anyone know why? What kind of planetary disasters will I create 
if I allow it to be used in 32-bit as well?

kevin

P.S.:  On an unrelated note, anyone know where to start looking for 
problems in pmac_zilog. My 8600 modem which worked fine in 2.4 is now 
essentially useless. Some problem with handshaking, I think.
