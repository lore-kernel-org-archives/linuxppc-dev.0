Return-Path: <prvs=658ea894d=david.vrabel@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55DD91A026C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 03:37:34 +1000 (AEST)
Message-ID: <55CA32D5.606@citrix.com>
Date: Tue, 11 Aug 2015 18:37:25 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Julien Grall <julien.grall@citrix.com>, <xen-devel@lists.xenproject.org>
CC: <linux-fbdev@vger.kernel.org>, <x86@kernel.org>, <netdev@vger.kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Jiri Slaby <jslaby@suse.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Russell King <linux@arm.linux.org.uk>,
 <linux-scsi@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 <stefano.stabellini@eu.citrix.com>, Ingo Molnar <mingo@redhat.com>,
 <linux-input@vger.kernel.org>, Jean-Christophe Plagniol-Villard
 <plagnioj@jcrosoft.com>, <ian.campbell@citrix.com>, "James E.J. Bottomley"
 <JBottomley@odin.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 <linux-arm-kernel@lists.infradead.org>, Juergen Gross <jgross@suse.com>,
 "Wei Liu" <wei.liu2@citrix.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 <linux-kernel@vger.kernel.org>, David Vrabel <david.vrabel@citrix.com>,
 <linux-api@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?B?Um9n?= =?UTF-8?B?ZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>
Subject: Re: [Xen-devel] [PATCH v3 0/9] Use correctly the Xen memory
 terminologies
References: <1438965282-19103-1-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438965282-19103-1-git-send-email-julien.grall@citrix.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/15 17:34, Julien Grall wrote:
> Hi all,
> 
> This patch series aims to use the memory terminologies described in
> include/xen/mm.h [1] for Linux xen code.

Applied to for-linus-4.3, thanks.

David
