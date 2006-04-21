Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF5F2679F9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Apr 2006 02:35:21 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FWyaz-0003KI-PT
	for linuxppc-embedded@ozlabs.org; Fri, 21 Apr 2006 18:35:01 +0200
Received: from icarus.icarus.com ([64.105.89.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 21 Apr 2006 18:35:01 +0200
Received: from steve by icarus.icarus.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Fri, 21 Apr 2006 18:35:01 +0200
To: linuxppc-embedded@ozlabs.org
From: Stephen Williams <steve@icarus.com>
Subject: Choices of 2.4 Kernel for PPC
Date: Fri, 21 Apr 2006 09:32:49 -0700
Message-ID: <e2b1fi$klf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I'd been using the BK tree (I know, old old) but it's been stable
for me for a while. But I'm starting to see so problems and I want
to work with a recent kernel tree. I'm using a PPC405GPr processor.

I downloaded the linux-2.4.32 tree from kernel.org, but it has
none of the Xilinx stuff so I immediately wonder about other things
it lacks for embedded PPC.

I downloaded the linux 2.4 .git tree from Denx, but the makefile
in top says it's based on 2.4.25, which is even older then what
I've got now.

I've looked on the penguinppc.org page, but it points me back
to the kernel.org distribution and possibly the bk repository.
Hmm...

So what tree is most universally accepted as current so far as
embedded PPC goes? And can the penguinppc.org pages be updated
to reflect the consensus?
-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
