Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id E2F54DE373
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 May 2008 19:46:33 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K21Bu-0005tT-Lj
	for linuxppc-embedded@ozlabs.org; Fri, 30 May 2008 02:46:30 -0700
Message-ID: <17555236.post@talk.nabble.com>
Date: Fri, 30 May 2008 02:46:30 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Block driver Concern.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all ...

I have devloped a test block driver on the host system. The driver is
expected to create 16 partitions on the disc and i am using a character
driver to read and write into the partitions where in i am using the request
function of the block driver.

The concern is that , after inserting the driver only one partition gets
created and not the all 16 


There are few question that remained unanswered till now for me :-
1. How could we write a bulk of data to the partitions created by the device
?
2. While inserting the device How is it possible to create 16 partitions
having the same major no.
3. How do in real case we use to write/read blocks of data to/from the disc
(I have used a char driver to test )??

If any of you have worked on Block drivers or have knowledge/Experiance then
please do share it with me .

Thank You 
Misbah <><
2.  
-- 
View this message in context: http://www.nabble.com/Block-driver-Concern.-tp17555236p17555236.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
