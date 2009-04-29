Return-Path: <tony@bakeyournoodle.com>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C70C0DDEEC
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 15:42:34 +1000 (EST)
Date: Wed, 29 Apr 2009 15:42:34 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: drivers/video/logo/logo_linux_mono.c build error
Message-ID: <20090429054234.GN16602@bilbo.ozlabs.org>
References: <20090427145031.99d4e0ac.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090427145031.99d4e0ac.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 27, 2009 at 02:50:31PM -0700, Andrew Morton wrote:
> 
> powerpc allmodconfig, current mainline:
> 
> drivers/video/logo/logo_linux_mono.c:11: error: logo_linux_mono_data causes a section type conflict
> 
> switching it from __initconst to __initdata "fixes" it.
> 
> I'm (illegally) using gcc-4.1.0.

You could use the compilers at:
	http://bakeyournoodle.com/cross/

Currently x86_64 hosted only, but i686  hosted compilers are building now :)
 
Yours Tony
