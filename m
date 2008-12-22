Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 5DA17DDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Dec 2008 17:58:05 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LEejk-0006U6-GK
	for linuxppc-embedded@ozlabs.org; Mon, 22 Dec 2008 06:57:57 +0000
Received: from CPE-124-190-96-129.vic.bigpond.net.au ([124.190.96.129])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 Dec 2008 06:57:56 +0000
Received: from daniel_ng11 by CPE-124-190-96-129.vic.bigpond.net.au with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 Dec 2008 06:57:56 +0000
To: linuxppc-embedded@ozlabs.org
From: Daniel Ng <daniel_ng11@lycos.com>
Subject: Re: Device Tree setup for 8272-based board
Date: Mon, 22 Dec 2008 06:57:45 +0000 (UTC)
Message-ID: <loom.20081222T064929-412@post.gmane.org>
References: <loom.20081219T062005-806@post.gmane.org>
	<494BFE2B.2010103@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott Wood <scottwood <at> freescale.com> writes:

> The cuboot file defines things like TARGET_CPM2 or TARGET_824x, which 
> influences the compilation of the bd_t struct.  It's messy, which is why 
> we use device trees now. 
> 


Thanks for your helpful responses Scott and Ming Qian. Now, from reading the 
docco can you please verify my understanding is correct?- 

First, I need a basic DTS file which will give me a basic Device Tree. The 
cuboot*.c file takes care of adding other parameters to the Device Tree passed 
from u-boot via the old bd_info struct. 

Is this correct? If so, would it be possible to do away with the DTS file 
altogether? On the other hand, would it be possible to do away with the 
cuboot*.c file by providing a complete DTS file?

Cheers,
Daniel
