Message-ID: <3ABA5768.6986524B@mvista.com>
Date: Thu, 22 Mar 2001 14:50:00 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: frowand@mvista.com
Cc: Ralph Blach <rblach@intrex.net>,
	linuxppc-embedded@lists.linuxppc.org,
	David Blythe <blythe@routefree.com>
Subject: Re: Proposed new kernel noncaching memory allocator for the 405gp
References: <3ABA1B6A.87C5FE9B@intrex.net> <3ABA5152.34E4F5B4@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Rowand wrote:

> Dan Malek has provided the functions consistent_alloc(), consistent_free(),
> and consistent_sync() for uses other than PCI.

But, what I haven't yet done is modify the general PowerPC PCI
functions (like pci_consistent_alloc()) to use these lower level
functions on the MPC8xx or the IBM4xx.  If you want to hack those
PCI functions in your local sources, go ahead, as the plan is to
make those work.  I just have to test against other platforms to
ensure I didn't break something, which is much more time consuming
that just making them work for a specific test environment.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
