Return-Path: <jason@lakedaemon.net>
Date: Tue, 16 Apr 2013 11:05:37 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Andrew Murray <Andrew.Murray@arm.com>
Subject: Re: [PATCH v7 0/3] of/pci: Provide common support for PCI DT parsing
Message-ID: <20130416150537.GC28693@titan.lakedaemon.net>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
Cc: linux-mips@linux-mips.org, siva.kallam@samsung.com,
 linux-pci@vger.kernel.org, linus.walleij@linaro.org,
 thierry.reding@avionic-design.de, Liviu.Dudau@arm.com, paulus@samba.org,
 linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk, jg1.han@samsung.com,
 jgunthorpe@obsidianresearch.com, thomas.abraham@linaro.org, arnd@arndb.de,
 devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com,
 kgene.kim@samsung.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com,
 monstr@monstr.eu, linux-kernel@vger.kernel.org, suren.reddy@samsung.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 16, 2013 at 11:18:25AM +0100, Andrew Murray wrote:
> This patchset factors out duplicated code associated with parsing PCI
> DT "ranges" properties across the architectures and introduces a
> "ranges" parser. This parser "of_pci_range_parser" can be used directly
> by ARM host bridge drivers enabling them to obtain ranges from device
> trees.
> 
> I've included the Reviewed-by and Tested-by's received from v5/v6 in this
> patchset, earlier versions of this patchset (v3) have been tested-by:
> 
> Thierry Reding <thierry.reding@avionic-design.de>
> Jingoo Han <jg1.han@samsung.com>
> 
> I've tested that this patchset builds and runs on ARM and that it builds on
> PowerPC and x86_64.

Series replaces v6 in mvebu/drivers

thx,

Jason.

> 
> Compared to the v6 sent by Andrew Murray, the following changes have
> been made in response to build errors/warnings:
> 
>  * Inclusion of linux/of_address.h in of_pci.c as suggested by Michal
>    Simek to prevent compilation failures on Microblaze (and others) and his
>    ack.
> 
>  * Use of externs, static inlines and a typo in linux/of_address.h in response
>    to linker errors (multiple defination) on x86_64 as spotted by a kbuild test
>    robot on (jcooper/linux.git mvebu/drivers)
> 
>  * Add EXPORT_SYMBOL_GPL to of_pci_range_parser function to be consistent
>    with of_pci_process_ranges function
