Return-Path: <mead@bnl.gov>
Received: from smtpgateway.bnl.gov (smtpgw.bnl.gov [130.199.3.132])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CC0DDDE39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 06:03:28 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: git files from secret lab
Date: Wed, 26 Sep 2007 16:03:18 -0400
Message-ID: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC5972EC@exchangemb3.bnl.gov>
In-Reply-To: <fa686aa40709260800o49cc9816j642358a14731d08f@mail.gmail.com>
References: <4e5a3720709260725x6d2e9faemc6a6053379610df8@mail.gmail.com>
	<D1AFFAE2CC4BD54CA4C1543CFF4A4FCC5972C9@exchangemb3.bnl.gov>
	<fa686aa40709260800o49cc9816j642358a14731d08f@mail.gmail.com>
From: "Mead, Joseph" <mead@bnl.gov>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>





>> Hi,
>>
>> I'm trying to download the xilinx patches from  Grant's git
repository,
>> but don't quite understand what I am doing.
>>
>> I cloned the tree from Linus' tree
>>
>> git clone
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>> (this worked fine)
>>
>> cd linux-2.6

>What version of git are you running (git --version).  That tree is
>using the virtual hosting feature of newer versions of git.  You need
>to be running at least version 1.5.

>Cheers,
>g.


Thanks, that was the problem...
