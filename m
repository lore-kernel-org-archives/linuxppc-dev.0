Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCHv1] crypto: caam - Added property fsl,
 sec-era in SEC4.0 device tree binding.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1358925668-10330-1-git-send-email-vakul@freescale.com>
Date: Tue, 12 Feb 2013 14:04:49 -0600
Message-Id: <8E12AE5C-7927-458A-B563-F7FC39143DEF@kernel.crashing.org>
References: <1358925668-10330-1-git-send-email-vakul@freescale.com>
To: Vakul Garg <vakul@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 23, 2013, at 1:21 AM, Vakul Garg wrote:

> This new property defines the era of the particular SEC version.
> The compatible property in device tree "crypto" node has been updated
> not to contain SEC era numbers.
> 
> Signed-off-by: Vakul Garg <vakul@freescale.com>
> ---
> Changelog:
> 	1. Marked fsl,sec-era as 'optional'.
> 
> .../devicetree/bindings/crypto/fsl-sec4.txt        |   12 +++++++++---
> 1 files changed, 9 insertions(+), 3 deletions(-)

applied to next.

I assume this supersedes http://patchwork.ozlabs.org/patch/204431/

- k
