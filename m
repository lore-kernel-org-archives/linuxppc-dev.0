Date: Fri, 18 Jul 2003 09:13:22 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Johnson, Stephen" <stevebj@artesyncp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kmalloc vs pci_alloc_consistent
Message-ID: <20030718091322.C26854@home.com>
References: <F9102D41F595D311ACA7009027DE2C840527B4D2@c3po.heurikon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F9102D41F595D311ACA7009027DE2C840527B4D2@c3po.heurikon.com>; from stevebj@artesyncp.com on Fri, Jul 18, 2003 at 08:34:24AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 18, 2003 at 08:34:24AM -0500, Johnson, Stephen wrote:
>
> I don't know the history behind pci_alloc and wanted to throw this out there
> to get some clarification.
>
> What's the benefit of pci_alloc over using kmalloc with flags for a
> cache-safe buffer?

Documentation/DMA-mapping.txt has a detailed explanation of the API.

Regards,
--
Matt Porter
mporter@kernel.crashing.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
