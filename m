Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: default stack size for threads changed
In-reply-to: <OF21CCB5A6.CDFDB6C1-ONC12576D2.00430B25-C12576D2.0043C4BB@transmode.se>
References: <OF21CCB5A6.CDFDB6C1-ONC12576D2.00430B25-C12576D2.0043C4BB@transmode.se>
Date: Tue, 23 Feb 2010 12:58:16 +1100
Message-ID: <14321.1266890296@neuling.org>
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message <OF21CCB5A6.CDFDB6C1-ONC12576D2.00430B25-C12576D2.0043C4BB@transmode.se> you wrote:
> 
> With current, 2.6.33-rc6, linux the default stack size changed from unlimited
> to 8MB:
> # > ulimit -s
> 8192
> 
> This makes NPTL allocate a 8MB stack for each thread that is created.
> This breaks in our embedded system. Although this
> can be fixed in our app I wonder if this is intentional?

When did this change from unlimited?

It's unlikely but this might be related
803bf5ec259941936262d10ecc84511b76a20921 (post rc7).  You'll also need
to grab this http://patchwork.kernel.org/patch/79365/.

Mikey

> 
>  Jocke
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
