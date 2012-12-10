Return-Path: <benh@kernel.crashing.org>
Message-ID: <1355179097.19932.5.camel@pasglop>
Subject: Re: pci and pcie device-tree binding - range No cells
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 11 Dec 2012 09:38:17 +1100
In-Reply-To: <20121210214323.6EA733E0921@localhost>
References: <50C5D387.90908@monstr.eu> <50C5F11D.9060006@gmail.com>
 <50C5FA3E.9030303@monstr.eu> <50C5FE0F.3050108@gmail.com>
 <50C601B6.2080107@monstr.eu> <20121210214323.6EA733E0921@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: monstr@monstr.eu, linux-pci@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Rob Herring <rob.herring@calxeda.com>, Rob Herring <robherring2@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-12-10 at 21:43 +0000, Grant Likely wrote:
> > Sorry for my pci ignorance (have never got hw for mb/zynq)
> > I just want to get better overview how we should we our drivers to
> be compatible.
> > 
> > Does it mean that pci is supposed be always 64 bit wide?
> > And there is no option to have just 32bit values.
> 
> Yes, PCIe addressing is always 64 bits wide. Even on 32bit PCI systems
> we use 64 bit PCI addressing in the device tree.

Right. The size & format of an address cell for PCI is specified in the
OF PCI bindings and we follow that binding. It's always 3 cells.

Cheers,
Ben.
