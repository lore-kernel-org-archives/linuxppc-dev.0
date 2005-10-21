Return-Path: <chris@2net.co.uk>
Received: from smtp813.mail.ukl.yahoo.com (smtp813.mail.ukl.yahoo.com
	[217.12.12.203]) by ozlabs.org (Postfix) with SMTP id 7BC306863A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 20:43:09 +1000 (EST)
Message-ID: <4358C4AC.2070900@2net.co.uk>
Date: Fri, 21 Oct 2005 11:36:28 +0100
From: Chris <chris@2net.co.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: kgdb support in Linux 2.6 for 8xx
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

It would be nice to be able to do some kernel debugging on my TQM823L 
board running 2.6 (2.6.13.1, to be exact). I have two questions

1. Has anyone got kgdboe working in this configuration? If so, could you 
give me a pointer to a patch?

2. kgdb over serial is lacking the getDebugChar and putDebugChar 
functions that used to be in 8xx_io/uart.c. Has anyone done any work on 
merging them into 2.6?

[OK, that's actually three questions. One just crept in]

Thanks in advance,
Chris
