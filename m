Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id 818CE2C0040
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2012 17:30:36 +1000 (EST)
Date: Wed, 1 Aug 2012 00:30:29 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: 3.5+: yaboot, Invalid memory access
In-Reply-To: <20120801020245.GC6467@thor.bakeyournoodle.com>
Message-ID: <alpine.DEB.2.01.1208010023110.15245@trent.utfs.org>
References: <alpine.DEB.2.01.1207302235170.26923@trent.utfs.org>
 <20120801020245.GC6467@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Aug 2012 at 12:02, Tony Breeds wrote:
> 1) can you also upload you vmlinux so we can poke at it.

I've uploaded the vmlinx (and System.map) to the same location:

  http://nerdbynature.de/bits/3.5.0/yaboot/

> 2) What is the dmseg.txt file there?  If you're unable to boot 3.5 how
> did you get the dmesg?

This is a dmesg from the working 3.5.0 (final), i.e. the release version 
which is working. The version that is not booting is "yesterday's git 
tree" or 37cd9600a9e20359b0283983c9e3a55d84347168 to be specific.

Sorry for the confusion. I only put the dmesg there so that people can 
have a look and see what type of machine this is.

Christian.
-- 
BOFH excuse #54:

Evil dogs hypnotised the night shift
