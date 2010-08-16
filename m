Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id 4D99FB70F7
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Aug 2010 22:30:57 +1000 (EST)
Message-ID: <4C692F7E.1060208@neli.hopto.org>
Date: Mon, 16 Aug 2010 14:30:54 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH 0/9] RapidIO: Set of patches to add Gen2 switches
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexandre Bounine wrote:
> This set of RapidIO patches adds support for new IDT Gen2 sRIO switch
> devices - CPS-1848 and CPS-1616.
> Adding these sRIO switches required to implement standard error recovery
> mechanism defined by the RapidIO specification.

This is not 'Gen2' specific, as these error management extensions also 
exist in v1.2/1.3 (?) of the specification? E.g. tsi56x and tsi57x could 
support this functionality?

Micha
