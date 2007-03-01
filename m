Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 68922DDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 12:35:21 +1100 (EST)
Received: from hopper.selinc.com (hopper.selinc.com [12.110.71.10])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	l211ZHSs019058
	for <linuxppc-embedded@ozlabs.org>; Wed, 28 Feb 2007 17:35:17 -0800
To: linuxppc-embedded@ozlabs.org
Subject: Kernel support for the TI1520 PCI-CardBus bridge?
MIME-Version: 1.0
Message-ID: <OFB8991C41.CAB80F63-ON88257291.0008226D-88257291.0008B663@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 28 Feb 2007 17:35:15 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

We're designing a new product and we want to put a CF card in it.  We're 
thinking the easiest way to do that is to put in a PCI-CF bridge and we 
would like to use the TI1520 because it's industrial rated which we need. 
We can get the parts but TI is refusing to give us any support because 
they're devoting 100% of their time to dealing with the Vista release. I'm 
curious if anyone has ever successfully gotten this part to work in linux. 
 I found it listed in pci_ids.h, but that doesn't mean it's actually 
used/working.  I'm not looking for a detailed explination right now, we're 
just trying to gage if this part would be a couple of weeks of work or a 
couple of months.  Thanks for any info.

See 'ya!

Bruce
