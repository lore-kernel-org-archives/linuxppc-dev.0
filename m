Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 7437A67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 04:38:04 +1000 (EST)
Date: Fri, 8 Apr 2005 14:35:49 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <e6dbd8188d62839f349bec5a4cd0b352@embeddededge.com>
Message-ID: <Pine.LNX.4.61.0504081434050.15953@localhost.localdomain>
References: <Pine.LNX.4.61.0504081010330.14089@localhost.localdomain>
	<e6dbd8188d62839f349bec5a4cd0b352@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cross-compiling under cygwin?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 8 Apr 2005, Dan Malek wrote:

>
> On Apr 8, 2005, at 10:13 AM, Robert P. J. Day wrote:
>
> >   i've just had a request from a colleague who wants to do all the
> > cross-compilation for our 8xx board on a windows box, rather than
> > linux.

> Just remember there is lots more to building and developing than
> compiling a kernel.  In addition to the compiler, you need lots of
> support tools.  Once you get a kernel, you have to create some kind
> of file system, of course NFS won't work on Windows, creating a
> ramdisk without a loopback device and file system support is quite a
> challenge, too.

a lot of that was part of the conversation.  i suspect i may have to
be more persuasive.  something involving a blunt instrument, perhaps.

> I don't understand why you wouldn't want to develop on a Linux (or
> at least Unix) host, since you need those skills and environment for
> the target.  Do they just like impossible challenges in their way to
> getting real work done? :-)

i'm going to assume that was rhetorical. :-)

rday
