Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc12.comcast.net (unknown [63.240.77.82])
	by ozlabs.org (Postfix) with ESMTP id A606B67B38
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 07:16:42 +1000 (EST)
Message-ID: <448F2B2A.60104@dlasys.net>
Date: Tue, 13 Jun 2006 17:16:26 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Init dies with unhandled signal 4
References: <448DC718.1010700@ics-ltd.com>
	<528646bc0606121303p35d4955dn60b82dc5fa6c9566@mail.gmail.com>
In-Reply-To: <528646bc0606121303p35d4955dn60b82dc5fa6c9566@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    I am trying to move my Pico E-12 port from 2.6.15 to the current 2.6
from Linus's git tree.
Most everything moved fine, but now "/init" dies with an unhandled
signal 4 which I beleive is an invalid CPU instruction.

I do not have this with 2.6.15 and Linus's tree is obviously more
bleeding edge.

I am just asking whether I should be trying to track down a problem with
my code or if this might be a problem in the git tree.






-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
