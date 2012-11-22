Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:120:8448::d00d])
 by ozlabs.org (Postfix) with ESMTP id 8DCCE2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2012 00:52:25 +1100 (EST)
Date: Thu, 22 Nov 2012 14:44:51 +0100
From: Borislav Petkov <bp@alien8.de>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 056/493] edac: remove use of __devexit_p
Message-ID: <20121122134451.GG17147@x1.alien8.de>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-56-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1353349642-3677-56-git-send-email-wfp5p@virginia.edu>
Cc: "Arvind R." <arvino55@gmail.com>, Mark Gross <mark.gross@intel.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>,
 Jason Uhlenkott <juhlenko@akamai.com>, gregkh@linuxfoundation.org,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Egor Martovetsky <egor@pasemi.com>, Doug Thompson <dougthompson@xmission.com>,
 Olof Johansson <olof@lixom.net>, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Tim Small <tim@buttersideup.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2012 at 01:20:05PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

Erm, I don't understand. __devexit_p is defined also for modules not
only for CONFIG_HOTPLUG:

#if defined(MODULE) || defined(CONFIG_HOTPLUG)
#define __devexit_p(x) x
#else
#define __devexit_p(x) NULL
#endif

AFAICT, we cannot remove it yet no?

Thanks.

-- 
Regards/Gruss,
Boris.
