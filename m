Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 4A359DE0C6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Dec 2007 17:09:45 +1100 (EST)
Date: Wed, 5 Dec 2007 00:13:51 -0600
From: Olof Johansson <olof@lixom.net>
To: vinay kumar <vinay453.techie@gmail.com>
Subject: Re: zImage.initrd.ebony image /ramdisk Image
Message-ID: <20071205061351.GB17391@lixom.net>
References: <e8e184520712032315s345679abu150461ead188f33e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e8e184520712032315s345679abu150461ead188f33e@mail.gmail.com>
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

On Tue, Dec 04, 2007 at 12:45:47PM +0530, vinay kumar wrote:
> I am trying to boot linux on ebony.
> Can any one please help me in either sharing a ready made image of
> kernel and ramdisk or united image.
> 
> How do we build a fresh image ourselves.?

There's a few different projects out there for building simple ramdisk images.

I think ELDK might have it (not sure): http://denx.de/

buildroot: http://buildroot.uclibc.org/

OpenEmbedded: http://openembedded.org/

LTIB: http://savannah.nongnu.org/projects/ltib/


-Olof
