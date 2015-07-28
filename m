Return-Path: <prvs=6444d210c=david.vrabel@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CC3E1A0DA1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 03:17:21 +1000 (AEST)
Message-ID: <55B7B91B.6010608@citrix.com>
Date: Tue, 28 Jul 2015 18:17:15 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Julien Grall <julien.grall@citrix.com>, <xen-devel@lists.xenproject.org>
CC: <ian.campbell@citrix.com>, <stefano.stabellini@eu.citrix.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 David Vrabel <david.vrabel@citrix.com>, Jiri Slaby <jslaby@suse.com>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Xen-devel] [PATCH 7/8] hvc/xen: Further s/MFN/GFN clean-up
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-8-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438095769-2560-8-git-send-email-julien.grall@citrix.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/07/15 16:02, Julien Grall wrote:
> HVM_PARAM_CONSOLE_PFN is used to retrieved the console PFN for HVM
> guest. It returns a PFN (aka GFN) and not a MFN.
> 
> Furthermore, use directly virt_to_gfn for both PV and HVM domain rather
> than doing a special case for each of the them.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
