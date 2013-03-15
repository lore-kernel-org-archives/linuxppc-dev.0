Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6406A2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 03:20:19 +1100 (EST)
Subject: Re: [PATCH] powerpc: remove "config 8260_PCI9"
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363274097.1335.83.camel@x61.thuisdomein>
Date: Fri, 15 Mar 2013 11:17:11 -0500
Message-Id: <5EB0C1E1-F71E-4B3C-8471-BA899FEC2DFD@kernel.crashing.org>
References: <1363274097.1335.83.camel@x61.thuisdomein>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 14, 2013, at 10:14 AM, Paul Bolle wrote:

> The last user of Kconfig symbol 8260_PCI9 got removed in release v3.2.
> Remove this symbol too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Untested.
> 
> 1) This probably is a second order effect of my commit
> 6805ab6daa2b589fe3242d05ddc47a9dbb0c4eb1 ("powerpc: drop unused Kconfig
> symbols"). Not sure how I missed that.
> 
> arch/powerpc/Kconfig | 5 -----
> 1 file changed, 5 deletions(-)

applied to next

- k
