Return-Path: <anton@samba.org>
Date: Sun, 3 Jun 2012 13:48:36 +1000
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: Fix size of st_nlink on 64bit
Message-ID: <20120603134836.4ffbd73d@kryten>
In-Reply-To: <20120603122850.3c5142767e429f34eb8a921e@canb.auug.org.au>
References: <20120602213452.66ba4cbb@kryten>
 <20120603122850.3c5142767e429f34eb8a921e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Stephen,

> > commit e57f93cc53b7 (powerpc: get rid of nlink_t uses, switch to
> > explicitly-sized type) changed the size of st_nlink on ppc64 from
> > a long to a short, resulting in boot failures.
> > 
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> 
> Would this affect my (early user mode) boot problems reported
> yesterday;
> 
> /init: 71: mknod: Permission denied
> /init: 88: mknod: Permission denied
> /init: 88: mknod: Permission denied

Very similar to the errors I was seeing so I think the patch will fix
it.

Anton
