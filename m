Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltxg5NkDzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:27:03 +1000 (AEST)
In-Reply-To: <1533573723-29692-1-git-send-email-rosattig@linux.vnet.ibm.com>
To: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>, 
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kstewart@linuxfoundation.org, rosattig@linux.vnet.ibm.com,
 mgreer@animalcreek.com, paulus@samba.org, sfr@canb.auug.org.au,
 daniel@iogearbox.net, dale@farnsworth.org, nfont@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, agust@denx.de, linux@roeck-us.net,
 arnd@arndb.de, npiggin@gmail.com, ast@kernel.org, hare@suse.de,
 tglx@linutronix.de, maurosr@linux.vnet.ibm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pombredanne@nexb.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/Makefiles: Convert ifeq to ifdef where possible
Message-Id: <41ltxc3PYJz9s0n@ozlabs.org>
Date: Thu,  9 Aug 2018 00:26:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-08-06 at 16:42:03 UTC, "Rodrigo R. Galvao" wrote:
> In Makefiles if we're testing a CONFIG_FOO symbol for equality with 'y'
> we can instead just use ifdef. The latter reads easily, so convert to
> it where possible.
> 
> Signed-off-by: Rodrigo R. Galvao <rosattig@linux.vnet.ibm.com>
> Reviewed-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/badf436f6fa5dc864d579d73fe7538

cheers
