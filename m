Date: Wed, 7 Mar 2001 11:21:01 +1100
From: Graham Stoney <greyham@research.canon.com.au>
To: kingseft@samsung.co.kr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Question] init does not find library files.....
Message-ID: <20010307112101.G4195@brixi.research.canon.com.au>
References: <H00002af04a809ff@MHS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <H00002af04a809ff@MHS>; from kingseft@samsung.co.kr on Wed, Mar 07, 2001 at 08:50:44AM +0900
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Mar 07, 2001 at 08:50:44AM +0900, kingseft@samsung.co.kr wrote:
>   But, when we ran this ramdisk iamge, init didn't found libc.so.6

I'm willing to bet my house that it's the pesky missing symlink from
/opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux to / on the target again.

Check the entry "Kernel panic: No init found..." on startup in the HOWTO at:
    file:/home/elph/greyham/HOWTO/PowerPC-Embedded-HOWTO-20.html#ss20.7

Regards,
Graham
--
Graham Stoney
Assistant Technology Manager
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
