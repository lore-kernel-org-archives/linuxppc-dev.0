Return-Path: <olaf@ibook.aepfle.de>
Received: from natblert.rzone.de (natblert.rzone.de [81.169.145.181])
	by ozlabs.org (Postfix) with ESMTP id 5C68467A33
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 19:12:50 +1000 (EST)
Date: Wed, 27 Sep 2006 11:12:33 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] move drivers/macintosh variables to BSS
Message-ID: <20060927091233.GA6381@aepfle.de>
References: <20060926201554.GA886@aepfle.de>
	<1159310719.4435.41.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1159310719.4435.41.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 27, Benjamin Herrenschmidt wrote:

> On Tue, 2006-09-26 at 22:15 +0200, Olaf Hering wrote:
> > Move all the initialized variables to bss and init them at runtime if needed.
> > Mark a version string as const.
> 
> What is the point of that ?

Globals are automatically set to zero, or what do you mean?
