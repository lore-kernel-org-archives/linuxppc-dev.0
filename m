Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17586.19290.301161.316289@cargo.ozlabs.ibm.com>
Date: Mon, 10 Jul 2006 22:43:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 15/20] [powerpc,
	netdevices] Constify & voidify get_property()
In-Reply-To: <200607101340.22068.jk@ozlabs.org>
References: <17582.14562.991790.920984@cargo.ozlabs.ibm.com>
	<200607101340.22068.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeremy Kerr writes:

> Hm, that's odd - you mean the patch doesn't apply, or that it introduces 
> incorrect whitepace? I can apply this patch (from patchwork or the list 
> archives) without problems.

The git-applymbox script says the patch is corrupt, because several of
the context lines that should start with <space><tab> had the space
removed.

Paul.
