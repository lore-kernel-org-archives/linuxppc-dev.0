Return-Path: <mikey@ozlabs.org>
To: Jeremy Kerr <jk@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: RFC/slightly offtopic: Automatic patchwork status updates 
In-reply-to: <200609271528.49260.jk@ozlabs.org> 
References: <200609271528.49260.jk@ozlabs.org>
Date: Wed, 27 Sep 2006 16:26:05 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060927062606.9591167B1A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Troy Rollo <troy@corvu.com.au>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> For some time now, we've been running patchwork on the linuxppc and 
> cbe-oss-dev lists. For those who haven't seen it, it collects and 
> tracks patches posted to the lists, and shows them here:
> 
>   http://patchwork.ozlabs.org/linuxppc
> and
>   http://patchwork.ozlabs.org/cbe-oss-dev
> 
> However, the patch 'state' (eg, accepted, rejected, debug only, changes 
> requested) doesn't get updated very often, as it can be an unnecessary 
> burden on the maintainers.
> 
> All this information is available from the actual upstream tree itself, 
> so essentially patchwork *should* be able to just mirror the state.

Personally, I use the git web server on kernel.org to see if my patches
are in a particular tree.  I have a bookmark something like this:

http://git.kernel.org/git/?p=linux/kernel/git/paulus/powerpc.git&a=search&h=HEAD&s=Jeremy+Kerr

This may not solve all the problems you are trying to solve with
patchworks though.  

Mikey
