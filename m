Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 179BCDE7B8
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 01:01:26 +1000 (EST)
Date: Wed, 6 Aug 2008 11:01:24 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: Big include file move breaks user mode
Message-ID: <20080806110124.40280d13@lappy.seanm.ca>
In-Reply-To: <200808061651.40361.arnd@arndb.de>
References: <20080805120916.2f39307c@lappy.seanm.ca>
	<200808061651.40361.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 6 Aug 2008 16:51:40 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> The user space headers are provided by your distribution, not
> by the kernel, so include/asm should be a directory, not a symlink.
> If you are building your own distro, don't just copy the files
> but rather use 'make headers_install' to get a sanitized version.

Sorry, I forgot to reply to the list :( Kumar mentioned the "make
headers_install" and I got it working with our build system. So
everything is back on track.

Cheers,
   Sean
