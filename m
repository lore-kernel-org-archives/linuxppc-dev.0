Return-Path: <Simon.Richter@kleinhenz.com>
Received: from kleinhenz.com (static.88-198-202-190.clients.your-server.de
	[88.198.202.190]) by ozlabs.org (Postfix) with ESMTP id 9E447DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 08:02:24 +1100 (EST)
Date: Tue, 11 Nov 2008 21:32:33 +0100
From: Simon Richter <sjr@debian.org>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Building dtc etc. for packaging
Message-ID: <20081111203232.GA13635@richter>
References: <4919C115.8040107@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4919C115.8040107@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, Nov 11, 2008 at 11:29:57AM -0600, Matt Sealey wrote:

> (the other tool we need is mkimage from U-Boot, I noticed Debian uses this
> same command name inside jigdo etc. too, sigh.. also you can't build the
> tools without the rest of U-Boot which is hard to envision doing just to
> get one command out of it - "make tools/mkimage" doesn't work and I got
> tired of reverse engineering the chickenscratch..)

I have a Debian package that basically just builds the tools into one binary
package, and the source tarball into another.

Didn't upload it back then, but I can see if I can find the time to get it
up to date.

   Simon
