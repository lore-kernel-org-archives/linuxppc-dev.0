Return-Path: <jdelvare@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 7D9912C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 02:04:14 +1000 (EST)
Subject: Re: [PATCH 0/7] rapidio: modularize rapidio subsystem
From: Jean Delvare <jdelvare@suse.de>
To: Alexandre Bounine <alexandre.bounine@idt.com>
In-Reply-To: <1372447136-5751-1-git-send-email-alexandre.bounine@idt.com>
References: <1372447136-5751-1-git-send-email-alexandre.bounine@idt.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Jul 2013 18:03:43 +0200
Message-ID: <1374768223.4604.207.camel@chaos.site>
Mime-Version: 1.0
Cc: Stef van Os <stef.van.os@Prodrive.nl>,
 Micha Nelissen <micha.nelissen@Prodrive.nl>, linux-kernel@vger.kernel.org,
 Andre van Herk <andre.van.herk@Prodrive.nl>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Alexandre,

Le Friday 28 June 2013 à 15:18 -0400, Alexandre Bounine a écrit :
> The following set of patches modifies kernel RapidIO subsystem to enable build
> and use of its components as loadable kernel modules. Combinations of statically
> linked and modular components are also supported.
> (...)

Thanks to this patch set, I was finally able to make all RapidIO support
modular in openSUSE kernels. This is very appreciated, thanks a lot!

-- 
Jean Delvare
Suse L3
