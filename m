Return-Path: <jbarnes@virtuousgeek.org>
Received: from outboundproxy6.bluehost.com (outbound-mail-313.bluehost.com
	[67.222.54.6]) by ozlabs.org (Postfix) with SMTP id 0D44DB7CED
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Feb 2010 11:26:25 +1100 (EST)
Date: Mon, 22 Feb 2010 16:23:56 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH v4 1/5] PCI: split up pci_read_bridge_bases()
Message-ID: <20100222162356.2e4b3a19@jbarnes-piketon>
In-Reply-To: <20100217201952.4013.62534.stgit@bob.kio>
References: <20100217201654.4013.70201.stgit@bob.kio>
	<20100217201952.4013.62534.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>,
	linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org,
	Peter Haight <peterh@sapros.com>,
	Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-am33-list@redhat.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, Yinghai Lu <yinghai@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 17 Feb 2010 13:19:52 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> 
> No functional change; this breaks up pci_read_bridge_bases() into separate
> pieces for the I/O, memory, and prefetchable memory windows, similar to how
> Yinghai recently split up pci_setup_bridge() in 68e84ff3bdc.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---

Applied this series, thanks Bjorn.  Hopefully this one will
successfully run the linux-next gauntlet too. :)

-- 
Jesse Barnes, Intel Open Source Technology Center
