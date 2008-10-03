Return-Path: <tony.luck@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id 7D816DE1B4
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 04:05:43 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Fri, 3 Oct 2008 10:55:44 -0700
Subject: RE: [RFC/PATCH 1/2] pci: Add ability to mmap legacy_io on some
	platforms
Message-ID: <57C9024A16AD2D4C97DC78E552063EA352D4987F@orsmsx505.amr.corp.intel.com>
References: <20081003094951.10B3FDE183@ozlabs.org>
In-Reply-To: <20081003094951.10B3FDE183@ozlabs.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I didn't have a chance to test that I didn't break ia64, so I would
> be if somebody could give it a spin there ! Thanks !

All my ia64 config variations still build cleanly with
these two patches applied.  I booted a couple of systems
too with no obvious ill-effects.

I have the same set of "legacy_io" and "legacy_mem" files
in /sys/class/pci_bus/xxxx:xx/ that I had before applying
these patches.  I'm not sure how to test that they still
"work".

-Tony
