Date: Thu, 25 Jan 2001 10:25:38 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
In-Reply-To: <3A6FC1EB.1CC0B893@mvista.com>
Message-ID: <Pine.GSO.4.10.10101251016230.20829-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 25 Jan 2001, Dan Malek wrote:

> When HIGHMEM is used, memory pages are mapped to virtual addresses
> that are not 1:1 mapped.  Our simple virt_to_phys macros won't work
> with HIGHMEM pages.

And they don't have to. If you have a highmem page, use kmap to get
temporary virtual mapping. On the other hand most of the drivers should
never see a highmem page.

> I would like to know who works on APUS as well.

I do currently.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
