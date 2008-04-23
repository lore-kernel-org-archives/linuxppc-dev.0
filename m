Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18446.48624.515912.541936@cargo.ozlabs.ibm.com>
Date: Wed, 23 Apr 2008 14:41:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [RFC patch 6/9] POWERPC remove -traditional
In-Reply-To: <20080422172842.427209743@polymtl.ca>
References: <20080422172404.502954084@polymtl.ca>
	<20080422172842.427209743@polymtl.ca>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	Sam Ravnborg <sam@ravnborg.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mathieu Desnoyers writes:
> Subject: [RFC patch 6/9] Re: [PATCH] Stringify support commas
>  > This is a no-no for those archs that still use -traditional.
>  > > I dunno if this is a problem for you at the moment and the
>  > > right fix is anyway to nuke -traditional.
>  > > 
>  > >     Sam
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> CC: Sam Ravnborg <sam@ravnborg.org>
> CC: paulus@samba.org
> CC: linuxppc-dev@ozlabs.org
> ---
>  arch/powerpc/boot/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks OK.  I'll put it in my tree.

Paul.
