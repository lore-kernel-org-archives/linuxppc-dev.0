Date: Thu, 22 Mar 2001 15:04:14 -0800
From: andrew may <acmay@acmay.homeip.net>
To: frowand@mvista.com
Cc: Ralph Blach <rblach@intrex.net>,
	linuxppc-embedded@lists.linuxppc.org,
	David Blythe <blythe@routefree.com>
Subject: Re: Proposed new kernel noncaching memory allocator for the 405gp
Message-ID: <20010322150414.C2787@ecam.san.rr.com>
References: <3ABA1B6A.87C5FE9B@intrex.net> <3ABA5152.34E4F5B4@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ABA5152.34E4F5B4@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 22, 2001 at 11:24:02AM -0800, Frank Rowand wrote:
> Dan Malek has provided the functions consistent_alloc(), consistent_free(),
> and consistent_sync() for uses other than PCI.  They are in linuxppc_2_5
> rev 1.446 and later (I'm not sure if they are in any earlier version).
> They are also in my active development kernel, but not yet in any kernel
> that I have put on my ftp site.

They are in the 405Gp kernel date Mar 1 on the ftp site.

If they are for things other than PCI they should use virt_to_phys
instead of virt_to_bus. On the 405gp this works since pci_dram_offset
is set to 0.

--
Andrew May

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
