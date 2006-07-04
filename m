Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 4 Jul 2006 16:58:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 7/20] [powerpc,iseries] Constify & voidify get_property()
Message-Id: <20060704165822.0a429eea.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue,  4 Jul 2006 16:46:44 +1000 (EST) Jeremy Kerr <jk@ozlabs.org> wrote:
>
> Now that get_property() returns a void *, there's no need to cast its
> return value. Also, treat the return value as const, so we can
> constify get_property later.
> 
> iseries platform changes.
> 
> Built for iseries_defconfig
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
