Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtjnM1MPLzDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 09:56:54 +1100 (AEDT)
Message-ID: <1490828197.3177.193.camel@kernel.crashing.org>
Subject: Re: [PATCH] macintosh: Do not arbitrarily limit architecture for
 macintosh drivers.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>, Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Thu, 30 Mar 2017 09:56:37 +1100
In-Reply-To: <CAK8P3a1qh5YA6-UZnoxVVO_HBp_sbZ_UEwzBnTVtRgYwJg09QQ@mail.gmail.com>
References: <20170329133318.16189-1-msuchanek@suse.de>
 <CAK8P3a1qh5YA6-UZnoxVVO_HBp_sbZ_UEwzBnTVtRgYwJg09QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-03-29 at 23:29 +0200, Arnd Bergmann wrote:
> Why not move the mac_hid module to drivers/input instead so
> it no longer depends on MACINTOSH_DRIVERS?
> 
> For the other mac drivers, it may be helpful to to add '||
> COMPILE_TEST'
> to the dependency line here to allow building them on ARM (after
> you have verified that we can in fact build them all without
> warnings),
> but that would be unrelated.

A bunch of them will rely on specific powermac infrastructure from
arch, it's likely they won't build.

Cheers,
Ben.
