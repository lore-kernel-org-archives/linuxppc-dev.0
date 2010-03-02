Return-Path: <galak@kernel.crashing.org>
Subject: Re: [RFC: PATCH 01/13] powerpc/booke: Add Stack Marking support to
	Booke Exception Prolog
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100301191301.20987.70132.sendpatchset@norville.austin.ibm.com>
Date: Tue, 2 Mar 2010 08:50:56 -0600
Message-Id: <68EF9A77-EB45-49D5-8496-686918DDC75C@kernel.crashing.org>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
	<20100301191301.20987.70132.sendpatchset@norville.austin.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 1, 2010, at 1:13 PM, Dave Kleikamp wrote:

> powerpc/booke: Add Stack Marking support to Booke Exception Prolog
> 
> From: Torez Smith <lnxtorez@linux.vnet.ibm.com>
> 
> Signed-off-by: Torez Smith  <lnxtorez@linux.vnet.ibm.com>
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> ---
> 
> arch/powerpc/kernel/head_booke.h |    5 +++++
> 1 files changed, 5 insertions(+), 0 deletions(-)

Can this be explained further as to what this gets us or does.

- k
