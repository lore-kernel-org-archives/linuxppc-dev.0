Return-Path: <slightlyunconventional@gmail.com>
MIME-Version: 1.0
Sender: slightlyunconventional@gmail.com
In-Reply-To: <20100305204324.18424.40814.sendpatchset@norville.austin.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
	<20100305204324.18424.40814.sendpatchset@norville.austin.ibm.com>
Date: Sun, 7 Mar 2010 15:08:31 -0800
Message-ID: <fb412d761003071508v15586071wf38bc1ae1ad17480@mail.gmail.com>
Subject: Re: [PATCH 05/13] powerpc/476: Add isync after loading mmu and debug
	spr's
From: Hollis Blanchard <hollis@penguinppc.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 5, 2010 at 12:43 PM, Dave Kleikamp
<shaggy@linux.vnet.ibm.com> wrote:
>
> powerpc/476: Add isync after loading mmu and debug spr's
>
> From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
>
> 476 requires an isync after loading MMU and debug related SPR's. =A0Some =
of
> these are in performance-critical paths and may need to be optimized, but
> initially, we're playing it safe.

Why is there sometimes #ifdef CONFIG_PPC_47x, sometimes not, and never
the cputable infrastructure which was intended for this sort of thing?

-Hollis
