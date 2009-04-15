Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BE31CDE03B
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Apr 2009 14:47:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18917.26295.736364.593691@drongo.ozlabs.ibm.com>
Date: Wed, 15 Apr 2009 14:46:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Robert Jennings <rcj@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: VRM unused page hinting
In-Reply-To: <20090414013741.GA8678@austin.ibm.com>
References: <20090414013741.GA8678@austin.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Robert Jennings writes:

> Adds support for the "unused" page hint which can be used in shared
> memory partitions to flag pages not in use, which will then be stolen
> before active pages by the hypervisor when memory needs to be moved to
> LPARs in need of additional memory.  Failure to mark pages as 'unused'
> makes the LPAR slower to give up unused memory to other partitions.

The patch also adds a kernel command line option.  That should be
mentioned in the patch description and documented in
Documentation/kernel-parameters.txt.  Also, I'd like you to choose a
better name for the kernel command line option than "cmma", which is
completely opaque to me -- it doesn't seem to be the name or even the
initials of anything in the patch.  Presumably it's somehow related to
CMO, but just how is not at all clear.

Paul.
