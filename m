Return-Path: <prvs=5836c538d=david.vrabel@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82A7A1A0E48
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2015 20:38:37 +1000 (AEST)
Message-ID: <5566F026.1030606@citrix.com>
Date: Thu, 28 May 2015 11:38:30 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Jan Beulich <JBeulich@suse.com>, <linuxppc-dev@lists.ozlabs.org>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hvc_xen: avoid uninitialized variable warning
References: <5566EDC6020000780007E67F@mail.emea.novell.com>
In-Reply-To: <5566EDC6020000780007E67F@mail.emea.novell.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28/05/15 09:28, Jan Beulich wrote:
> Older compilers don't recognize that "v" can't be used uninitialized;
> other code using hvm_get_parameter() zeros the value too, so follow
> suit here.

Applied to for-linus-4.2, thanks.

David
