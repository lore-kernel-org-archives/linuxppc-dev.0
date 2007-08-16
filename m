Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [193.200.147.14])
	by ozlabs.org (Postfix) with ESMTP id 64149DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 18:01:40 +1000 (EST)
Received: from [10.21.30.78] (snitkin.dutchspace.nl [10.21.30.78])
	by kirk.dutchspace.nl (8.11.7p1+Sun/8.10.2) with ESMTP id l7G7vrN00777
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 09:57:53 +0200 (MEST)
Message-ID: <46C40460.2000806@dutchspace.nl>
Date: Thu, 16 Aug 2007 10:01:36 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Problem getting a webserver running
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am trying to get a webserver on my embedded target box (an MVME3100 
PPC board, running ELDK 4.1 with kernel 2.6.14). I can start httpd, but 
when I try to connect I do not get any data. The connection is 
established (using telnet localhost 80), but I do not get any data back 
from the server. I also do not see any entries in the logfile.
Also, when I use appWeb or GoAhead webserver, I see the same problem. 
What could be causing this?

Kind regards,
    Johan Borkhuis
