Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-158.bluehost.com (outbound-mail-158.bluehost.com
	[67.222.39.38]) by ozlabs.org (Postfix) with SMTP id BAB75B7BEE
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Feb 2010 08:34:33 +1100 (EST)
Date: Fri, 12 Feb 2010 13:26:23 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v3 1/7] PCI: split up pci_read_bridge_bases()
Message-ID: <20100212132623.79fdf5cd@jbarnes-piketon>
In-Reply-To: <20100212165952.19522.19555.stgit@bob.kio>
References: <20100212165532.19522.47240.stgit@bob.kio>
	<20100212165952.19522.19555.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>,
	linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org,
	Peter Haight <peterh@sapros.com>,
	Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-acpi@vger.kernel.org, linux-am33-list@redhat.com,
	linux-alpha@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Yinghai Lu <yinghai@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 12 Feb 2010 09:59:52 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> 
> No functional change; this breaks up pci_read_bridge_bases() into
> separate pieces for the I/O, memory, and prefetchable memory windows,
> similar to how Yinghai recently split up pci_setup_bridge() in
> 68e84ff3bdc.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---

Applied to my linux-next branch replacing the old ones, thanks Bjorn.

-- 
Jesse Barnes, Intel Open Source Technology Center
