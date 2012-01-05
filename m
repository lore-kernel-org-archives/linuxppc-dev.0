Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsl/mpic: Document and use the "big-endian" device-tree
 flag
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1324571123-11577-1-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Thu, 5 Jan 2012 12:35:30 -0600
Message-Id: <DE2E2CDA-D373-4E48-82EA-B8E1F05236D9@kernel.crashing.org>
References: <1324571123-11577-1-git-send-email-Kyle.D.Moffett@boeing.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: linux-doc@vger.kernel.org, Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 devicetree-discuss@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>,
 Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org,
 Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 22, 2011, at 10:25 AM, Kyle Moffett wrote:

> The MPIC code checks for a "big-endian" property and sets the flag
> MPIC_BIG_ENDIAN if one is present.  Unfortunately, the PowerQUICC-III
> compatible device-tree does not specify it, so all of the board ports
> need to manually set that flag when calling mpic_alloc().
> 
> Document the flag and add it to the pq3 device tree.  Existing code
> will still need to pass the MPIC_BIG_ENDIAN flag because their dtb may
> not have this property, but new platforms shouldn't need to do so.
> 
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
> ---
> .../devicetree/bindings/powerpc/fsl/mpic.txt       |    9 ++++++++-
> arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi            |    1 +
> 2 files changed, 9 insertions(+), 1 deletions(-)

need to update arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi

- k
