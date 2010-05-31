Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 8D8D0B7D47
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 May 2010 19:33:45 +1000 (EST)
Subject: Re: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU is
	not set
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1275271231.1931.547.camel@pasglop>
Date: Mon, 31 May 2010 11:33:40 +0200
Message-Id: <FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>
References: <1275270628.1931.540.camel@pasglop>
	<1275271231.1931.547.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 31.05.2010, at 04:00, Benjamin Herrenschmidt wrote:

> On Mon, 2010-05-31 at 11:50 +1000, Benjamin Herrenschmidt wrote:
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>> arch/powerpc/kernel/ppc_ksyms.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> Alex, this is just a temporary fix to remove the build breakage for 40x
> etc... but please, update KVM to just build-in its own.

What's the bad part in reusing the existing code?

> Don't we have .o's that are always built into modules nowadays ?

I don't think I understand what you mean.


Alex
