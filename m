Return-Path: <trini@kernel.crashing.org>
Date: Fri, 4 Feb 2005 07:45:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olof Johansson <olof@austin.ibm.com>
Message-ID: <20050204144532.GN15359@smtp.west.cox.net>
References: <20050204072254.GA17565@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050204072254.GA17565@austin.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, hpa@zytor.com, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 04, 2005 at 01:22:54AM -0600, Olof Johansson wrote:

> Hi,
> 
> It's getting pretty old to have see and type cur_cpu_spec->cpu_features
> & CPU_FTR_<feature>, when a shorter and less TLA-ridden macro is more
> readable.
> 
> This also takes care of the differences between PPC and PPC64 cpu
> features for the common code; most places in PPC could be replaced with
> the macro as well.

It'd be nice if someone went and changed ppc32's cpu feature from an
array and matched ppc64, while we're in here...

-- 
Tom Rini
http://gate.crashing.org/~trini/
