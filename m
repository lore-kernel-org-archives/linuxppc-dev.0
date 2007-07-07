Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 6489CDE176
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 02:49:59 +1000 (EST)
Message-ID: <468FC4AC.9030701@ru.mvista.com>
Date: Sat, 07 Jul 2007 20:51:56 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] [ide] mmio ide support
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
	<200707071419.52650.arnd@arndb.de>
In-Reply-To: <200707071419.52650.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

>>This adds support for MMIO IDE device like CompactFlash 
>>in TrueIDE mode.

>>Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com> 
>>Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

> Hmm, are we still adding new IDE drivers? Do you also have a

    Yes, why not?

> driver for the new libata layer?

    No (sorry for replying for Vitaly but I know the situation).

> I think it would even be simpler to do.

    Wel have no interest in it right now.

> You could also make it an of_platform_driver at the same time
> instead of adding more cruft to fsl_soc.c. Since we're already

    That's a fair point (and fsl_soc.c doesn't seem proper place anyway).

> about to add the electra_ide.c driver in 2.6.23, I guess there
> should really be _one_ driver that is able to handle all
> of_device based ATA hosts.

    One driver to rule them all. :-)
    That may be not so simple as it seems...

MBR, Sergei
