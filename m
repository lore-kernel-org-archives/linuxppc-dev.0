Return-Path: <thisismevinay@yahoo.co.in>
Received: from web8405.mail.in.yahoo.com (web8405.mail.in.yahoo.com
	[202.43.219.153]) by ozlabs.org (Postfix) with SMTP id 8DA9BDDF89
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 15:46:56 +1100 (EST)
Date: Tue, 30 Jan 2007 20:46:48 -0800 (PST)
From: vinay hegde <thisismevinay@yahoo.co.in>
Subject: Differentiate between two e500 core (in mult-core e500)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <11163.68650.qm@web8405.mail.in.yahoo.com>
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

I have a need to write a POST sort of a test to test
L1 data/inst cache residing on each of the e500 v2
multi-core seperately (for a network hardware). This
is because multicore e500 has seperate L1 caches and
shared L2 cache.

This is for mpc8572. I learnt from this list that
mpc8572 isn't out yet, but thought that
differentiating between e500 mult-cores has nothing to
do with mpc8572.

Please let me know if you have any inputs.

Thanks,
Vinay.


 
____________________________________________________________________________________
Expecting? Get great news right away with email Auto-Check. 
Try the Yahoo! Mail Beta.
http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html 
