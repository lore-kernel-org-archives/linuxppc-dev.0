Return-Path: <blofeldus@yahoo.com>
Received: from web53505.mail.yahoo.com (web53505.mail.yahoo.com
	[206.190.37.66]) by ozlabs.org (Postfix) with SMTP id A6FC02BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 03:39:25 +1100 (EST)
Message-ID: <20041115163244.57008.qmail@web53505.mail.yahoo.com>
Date: Mon, 15 Nov 2004 08:32:43 -0800 (PST)
From: roger blofeld <blofeldus@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Lite5200 FEC Driver on linux 2.6 broken?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to get a simple app running on a Lite5200 and am having a
TCP/IP problem. Using tcpdump/ethereal I have learned that the Lite5200
ethernet works fine until the client sends a TCP retransmission
request. Then the Lite5200 replies with packets having incorrect
checksums. Each successive Lite5200 packet appears to also lose two
bytes of data (i.e., the packet size is correct, but the data is not
the same for each retransmission because two bytes have been dropped
from the start of the payload).

Could this be a problem with the FEC driver? Bestcomm? How can I figure
out what is broken here? Any help gladly accepted!
 
I started with Sylvain Munaut's kernel at
http://www.246tnt.com/mpc52xx/ and have also tried starting with the
linux-2.5 tree and pulling Sylvain's tree into it to see if newer
kernels worked better. I also tried using the recently updated bestcomm
interface from denx.de with these kernels with the same result.

Thanks
-roger



		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 
