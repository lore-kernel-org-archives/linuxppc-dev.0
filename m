Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 832C22C0108
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 07:13:17 +1000 (EST)
Message-ID: <1376341985.32100.174.camel@pasglop>
Subject: Re: [PATCH 2/2] Register bootmem pages at boot on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 13 Aug 2013 07:13:05 +1000
In-Reply-To: <5208DCBC.7060205@linux.vnet.ibm.com>
References: <52050ACE.4090001@linux.vnet.ibm.com>
 <52050B80.8010602@linux.vnet.ibm.com> <1376266763.32100.144.camel@pasglop>
 <5208DCBC.7060205@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-12 at 08:01 -0500, Nathan Fontenot wrote:
> > Can you tell me a bit more, the above makes me nervous...
> 
> Ok, I agree. that message isn't quite right.
> 
> What I wanted to convey is that memory hotplug is not fully supported
> on powerpc with SPARSE_VMEMMAP enabled.. Perhaps the message should read
> "Memory hotplug is not fully supported for bootmem info nodes".
> 
> Thoughts?

Since SPARSE_VMEMMAP is our default and enabled in our distros, that mean
that memory hotplug isn't fully supported for us in general ?

What do you mean by "not fully supported" ? What precisely is missing ?
What will happen if one tries to plug or unplug memory?

Shouldn't we fix it ?

Cheers,
Ben.
