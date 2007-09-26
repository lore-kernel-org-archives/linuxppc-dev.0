Return-Path: <mead@bnl.gov>
Received: from smtpout.bnl.gov (smtpout.bnl.gov [130.199.3.136])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7047DDEA2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 01:12:27 +1000 (EST)
Received: from smtpgateway1.bnl.local ([172.16.1.65] helo=smtpgateway.bnl.gov)
	by smtpout.bnl.gov with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(SMTP out virtual0) serial 1IaYGi-0007pl-Lv
	for linuxppc-embedded@ozlabs.org; Wed, 26 Sep 2007 10:53:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: git files from secret lab
Date: Wed, 26 Sep 2007 10:53:32 -0400
Message-ID: <D1AFFAE2CC4BD54CA4C1543CFF4A4FCC5972C9@exchangemb3.bnl.gov>
In-Reply-To: <4e5a3720709260725x6d2e9faemc6a6053379610df8@mail.gmail.com>
References: <4e5a3720709260725x6d2e9faemc6a6053379610df8@mail.gmail.com>
From: "Mead, Joseph" <mead@bnl.gov>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,=20

I'm trying to download the xilinx patches from  Grant's git repository,
but don't quite understand what I am doing.

I cloned the tree from Linus' tree

git clone
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
(this worked fine)

cd linux-2.6

git fetch git://git.secretlab.ca/git/linux-2.6.git virtex-dev:virtex-dev

I get the error message:
Fatal: unexpected EOF
Fetch failure: git://git.secretlab.ca/git/linux-2.6.git



Thanks,
Joe
