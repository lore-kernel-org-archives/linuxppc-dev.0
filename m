Message-ID: <027a01c2070f$2ffe6420$e1a8459b@ntu.edu.sg>
From: "shaowei dai" <dshaowei@rfnetech.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <022501c20633$cbeb4f10$1a11efcb@industrialDiv.hanasys.co.kr> <20020528062351.A2267@home.com> <002b01c206cd$59f7a760$1a11efcb@industrialDiv.hanasys.co.kr> <20020529054737.GE16537@zax>
Subject: Re: map iomem in linux_2_4_dev
Date: Wed, 29 May 2002 20:48:52 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, David,  Sangmoon and all:

Thanks for all the input.

Now i understand why m8xx_pcmcia.c needs to use io_block_mapping. If we can
use ioremap in the driver, then
we don't need to map the io mem in kernel init. Maybe we can do some
improvement later on this driver.

regards


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
