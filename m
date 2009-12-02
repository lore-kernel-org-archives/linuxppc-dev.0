Return-Path: <dwalker@fifo99.com>
Received: from fifo99.com (fifo99.com [67.223.236.141])
	by ozlabs.org (Postfix) with ESMTP id 12F11B7B66
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 04:51:27 +1100 (EST)
Subject: Re: [v10 PATCH 9/9]: POWER: Enable default_idle when power_save=off
From: Daniel Walker <dwalker@fifo99.com>
To: arun@linux.vnet.ibm.com
In-Reply-To: <20091202100346.GJ27251@linux.vnet.ibm.com>
References: <20091202095427.GA27251@linux.vnet.ibm.com>
	<20091202100346.GJ27251@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Dec 2009 09:41:38 -0800
Message-ID: <1259775698.25622.2.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-12-02 at 15:33 +0530, Arun R Bharadwaj wrote:
> +int boot_option_idle_override = 0;
> + 

Doesn't need to be set to zero AFAIK, since we do a mass initialization
to zero during boot up. Did you notice some type of failure when you
didn't initialize that to zero?

(checkpatch output below..)
--

ERROR: do not initialise externals to 0 or NULL
#97: FILE: arch/powerpc/kernel/idle.c:43:
+int boot_option_idle_override = 0;

total: 1 errors, 0 warnings, 0 checks, 31 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
