Return-Path: <amodra@bigpond.net.au>
Received: from grove.modra.org (CPE-144-136-172-108.sa.bigpond.net.au
	[144.136.172.108]) by ozlabs.org (Postfix) with ESMTP id 8B51B67BCE
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2006 18:59:50 +1000 (EST)
Date: Wed, 12 Apr 2006 18:23:11 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Sai prasanna <saiprasannasp@yahoo.com>
Subject: Re: BFD 2.16.1 assertion fail
Message-ID: <20060412085311.GE21232@bubble.grove.modra.org>
References: <20060412073814.39382.qmail@web54313.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060412073814.39382.qmail@web54313.mail.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2006 at 12:38:14AM -0700, Sai prasanna wrote:
> /home/foo/build-install/powerpc-ppc-linux-gnu/bin/ld: BFD 2.16.1 assertion fail../../binutils-2.16.1/bfd/elf32-ppc.c:5397

You will likely be much better off with a new CVS binutils.  2.16.1 was
released almost a year ago, and a lot of bugs have been fixed since
then.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
