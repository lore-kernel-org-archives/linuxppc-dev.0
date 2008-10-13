Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-156.bluehost.com (outbound-mail-156.bluehost.com
	[67.222.39.36]) by ozlabs.org (Postfix) with SMTP id 1467ADE02D
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 04:29:19 +1100 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Add legacy PCI access via sysfs
Date: Mon, 13 Oct 2008 10:29:11 -0700
References: <20081010025101.B48CADDEF7@ozlabs.org>
	<200810101039.18300.jbarnes@virtuousgeek.org>
	<20081013140734.GA9793@yoda.jdub.homelinux.org>
In-Reply-To: <20081013140734.GA9793@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810131029.11822.jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday, October 13, 2008 7:07 am Josh Boyer wrote:
> On Fri, Oct 10, 2008 at 10:39:18AM -0700, Jesse Barnes wrote:
> >On Thursday, October 9, 2008 7:50 pm Benjamin Herrenschmidt wrote:
> >> This patch adds support for legacy_io and legacy_mem files in
> >> bus class directories in sysfs for powerpc
> >>
> >> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >> ---
> >
> >Applied to linux-next, thanks.
>
> Is that targeted towards .28 or .29?  Ben has a 4xx specific patch
> that depends on this one, and I just need to know which version to
> bring that in for.

I was planning on sending it for .28.

Jesse
