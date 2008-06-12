Return-Path: <amodra@bigpond.net.au>
Received: from nschwmtas04p.mx.bigpond.com (nschwmtas04p.mx.bigpond.com
	[61.9.189.146]) by ozlabs.org (Postfix) with ESMTP id E5301DDFF7
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 18:15:54 +1000 (EST)
Date: Thu, 12 Jun 2008 17:45:53 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: powerpc build failure
Message-ID: <20080612081553.GA22457@bubble.grove.modra.org>
References: <20080611192748.686236fd.sfr@canb.auug.org.au>
	<20080611095951.GB14033@elte.hu>
	<18512.32267.636550.47385@cargo.ozlabs.ibm.com>
	<20080612053335.GA22035@bubble.grove.modra.org>
	<20080612170505.6049fa75.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612170505.6049fa75.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 05:05:05PM +1000, Stephen Rothwell wrote:
> /usr/bin/ld: --relax and -r may not be used together

Can't you arrange so that --relax is only used on the final link?  Of
course, if you have mashed all the input .text sections together with
"ld -r", resulting in one monster .text then --relax quite likely
won't help.  ld can't break apart an input section to insert
trampolines in the middle.

-- 
Alan Modra
Australia Development Lab, IBM
