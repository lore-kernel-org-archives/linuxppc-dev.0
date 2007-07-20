Return-Path: <prvs=lokowich/072119e812@acdstar.com>
Received: from sentry.acdstar.com (mail.acdstar.com [209.98.244.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E376EDDE16
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 02:07:55 +1000 (EST)
Received: from MailerDaemon by sentry.acdstar.com with local-bsmtp (Exim 4.63)
	(envelope-from <lokowich@acdstar.com>) id 1IBumj-0007dY-HA
	for linuxppc-embedded@ozlabs.org; Fri, 20 Jul 2007 10:52:53 -0500
Received: from [192.168.2.3] (port=60080 helo=mail.acdstar.com)
	by sentry.acdstar.com with esmtp (Exim 4.63)
	(envelope-from <lokowich@acdstar.com>) id 1IBumg-0007dP-0M
	for linuxppc-embedded@ozlabs.org; Fri, 20 Jul 2007 10:52:50 -0500
Received: from [192.168.2.105] (rnd-03.int.acdstar.com [192.168.2.105])
	by mail.acdstar.com (8.13.6/8.13.6) with ESMTP id l6KFqM5R019889
	for <linuxppc-embedded@ozlabs.org>; Fri, 20 Jul 2007 10:52:22 -0500
Message-ID: <46A0D76E.4030101@acdstar.com>
Date: Fri, 20 Jul 2007 10:40:30 -0500
From: lokowich <lokowich@acdstar.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: SDRAM failures on MPC5200B
Content-Type: multipart/alternative;
	boundary="------------050903060002030509050804"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050903060002030509050804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We're working on bringing up a MPC5200B version of our original MPC5200 
board using U-Boot 1.1.4 configured for Icecube/Lite5200B.  Other than 
the CPU, the board is identical.  The bootloader crashes just after 
relocation to RAM, often with a Program Check Exception, typically a 
memory corruption issue.  I noticed failures at different stages after 
relocation based on content, suggesting problems with upper SDRAM.  If I 
force the initram to 1/2 the determined size (64MB instead of 128MB), 
then everything works well through kernel load and initialization.  
We've added termination resistors to improve AD signals, to no avail.  
Memory tests work fine too.  Any help is appreciated.

Thanks,
Mark Lokowich
Systems Engineer
Advanced Communication Design
7901 12th Ave. So.
Bloomington, MN 55425
952-854-4000
lokowich@acdstar.com

This email was Anti Virus checked by Astaro Security Gateway. http://www.astaro.com


--------------050903060002030509050804
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Verdana">We're working on bringing up a MPC5200B version of
our original MPC5200 board using U-Boot 1.1.4 configured for
Icecube/Lite5200B.&nbsp; Other than the CPU, the board is identical.&nbsp; The
bootloader crashes just after relocation to RAM, often with a Program
Check Exception, typically a memory corruption issue.&nbsp; I noticed
failures at different stages after relocation based on content,
suggesting problems with upper SDRAM.&nbsp; If I force the initram to 1/2
the determined size (64MB instead of 128MB), then everything works well
through kernel load and initialization.&nbsp; We've added termination
resistors to improve AD signals, to no avail.&nbsp; Memory tests work fine
too.&nbsp; Any help is appreciated.<br>
<br>
Thanks,<br>
Mark Lokowich<br>
Systems Engineer<br>
Advanced Communication Design<br>
7901 12th Ave. So.<br>
Bloomington, MN 55425<br>
952-854-4000<br>
<a class="moz-txt-link-abbreviated" href="mailto:lokowich@acdstar.com">lokowich@acdstar.com</a><br>
</font>
</body>
</html>

<pre>This email was Anti Virus checked by Astaro Security Gateway. http://www.astaro.com</pre>


--------------050903060002030509050804--
