Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419P951yTVzF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 09:21:13 +1000 (AEST)
In-Reply-To: <20180614152742.21075-1-mjeanson@efficios.com>
To: Michael Jeanson <mjeanson@efficios.com>, 
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stable@vger.kernel.org, Michael Jeanson <mjeanson@efficios.com>,
 Paul Mackerras <paulus@samba.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vakul Garg <vakul.garg@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 Scott Wood <swood@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: powerpc/e500mc: Set assembler machine type to e500mc
Message-Id: <419P944XMVz9s3C@ozlabs.org>
Date: Wed, 20 Jun 2018 09:21:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-06-14 at 15:27:42 UTC, Michael Jeanson wrote:
> In binutils 2.26 a new opcode for the "wait" instruction was added for the
> POWER9 and has precedence over the one specific to the e500mc. Commit
> ebf714ff3756 ("powerpc/e500mc: Add support for the wait instruction in
> e500_idle") uses this instruction specifically on the e500mc to work around
> an erratum.
> 
> This results in an invalid instruction in idle_e500 when we build for the
> e500mc on bintutils >= 2.26 with the default assembler machine type.
> 
> Since multiplatform between e500 and non-e500 is not supported, set the
> assembler machine type globaly when CONFIG_PPC_E500MC=y.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Kumar Gala <galak@kernel.crashing.org>
> CC: Vakul Garg <vakul.garg@nxp.com>
> CC: Scott Wood <swood@redhat.com>
> CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-kernel@vger.kernel.org
> CC: stable@vger.kernel.org

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/69a8405999aa1c489de4b8d349468f

cheers
