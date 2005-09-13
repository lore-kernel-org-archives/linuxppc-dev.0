Return-Path: <chris@2net.co.uk>
Received: from smtp813.mail.ukl.yahoo.com (smtp813.mail.ukl.yahoo.com
	[217.12.12.203]) by ozlabs.org (Postfix) with SMTP id EBAF968259
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Sep 2005 19:13:05 +1000 (EST)
Message-ID: <4326968F.5030609@2net.co.uk>
Date: Tue, 13 Sep 2005 10:06:23 +0100
From: Chris <chris@2net.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: gdb hangs on Linux 2.6.11 on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am running Linux 2.6.11 on a TQM823L development board. I find that 
gdb (version 6.3) hangs when I try to run an application - any 
application, even a simple helloworld. It's not just gdb hanging, the 
whole system is stone dead.

Before I start digging into the problem I would like to ask if anybody 
on this list has any experience, good or bad, of gdb on 2.6.xx on 8xx.

TIA,

Chris.
