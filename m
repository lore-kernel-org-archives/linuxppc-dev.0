Return-Path: <neko@genesi-usa.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 5C079DE031
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 04:30:02 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1114976yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 09:30:00 -0800 (PST)
Message-ID: <4919C115.8040107@genesi-usa.com>
Date: Tue, 11 Nov 2008 11:29:57 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Building dtc etc. for packaging
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For some of what we're doing with SUSE now I've determined we should really
be packaging the device tree compiler (and libfdt) so that we can install and
script it, along with some other stuff from U-Boot (not for this mail).

I was wondering if the recommended way would be to use the dtc found in
the kernel-source or to use the git repo at git.jdl.com to grab it and
build it. The one in the kernel is seemingly impossible to build without
some tweaking around (I can't find a target for make that does it) so
I also wonder about a hint here on what to do to create it from the
kernel source so we can pull it out for a local system install.

(the other tool we need is mkimage from U-Boot, I noticed Debian uses this
same command name inside jigdo etc. too, sigh.. also you can't build the
tools without the rest of U-Boot which is hard to envision doing just to
get one command out of it - "make tools/mkimage" doesn't work and I got
tired of reverse engineering the chickenscratch..)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
