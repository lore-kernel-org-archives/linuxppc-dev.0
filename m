Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214]) by ozlabs.org (Postfix) with ESMTP id 54B3AB6F06
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 19:01:27 +1100 (EST)
Received: by ewy6 with SMTP id 6so10940777ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 00:01:25 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<1262216393.29396.41.camel@localhost.localdomain>
	<fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
Date: Thu, 31 Dec 2009 09:01:22 +0100
In-Reply-To: <fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
	(Grant Likely's message of "Wed, 30 Dec 2009 17:01:35 -0700")
Message-ID: <87skartvvx.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Peter Tyser <ptyser@xes-inc.com>,
	linux-kbuild@vger.kernel.org, u-boot <u-boot@lists.denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> Personally, I don't get any benefit out of the new image format,
 Grant> so I haven't spent any time looking at it.  However, I'm
 Grant> concerned about the drift back towards a different image per
 Grant> target when the move over the last 4 years has been towards
 Grant> multiplatform kernel images.  I certainly don't want to
 Grant> encourage embedding the device tree blob into the kernel image,
 Grant> and I'm not very interested in merging code to do that into the
 Grant> kernel tree.  If someone really needs to do that for their
 Grant> particular target, it is certainly easy enough for them to weld
 Grant> in the .dtb after the fact before transferring the image to the
 Grant> target, but I want that mode to be the exception, not the rule.

I understand the advantages of being able to compile multiplatform
kernels - But for the typical embedded device, having the device tree
together with the kernel makes stuff a lot simpler when upgrading
because of the version depencies of the dts.

That's also why I submitted the (nacked) multifile uimage support some
time ago:

http://thread.gmane.org/gmane.linux.ports.ppc64.devel/46825/

The fitimage stuff is the logical continuation of that.

-- 
Bye, Peter Korsgaard
