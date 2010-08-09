Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [70.86.134.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 20FBCB6EF2
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 12:44:34 +1000 (EST)
Date: Sun, 8 Aug 2010 21:44:31 -0500
From: Olof Johansson <olof@lixom.net>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: inline ppc64_runlatch_off
Message-ID: <20100809024431.GA23129@lixom.net>
References: <20100806045315.GR29316@kryten> <20100806080227.GA17423@lixom.net>
	<20100806132819.GU29316@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100806132819.GU29316@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 06, 2010 at 11:28:19PM +1000, Anton Blanchard wrote:
>  
> Hi Olof,
> 
> > No semicolon here.
> 
> Nice catch!
> 
> Anton
> 
> I'm sick of seeing ppc64_runlatch_off in our profiles, so inline it
> into the callers. To avoid a mess of circular includes I didn't add
> it as an inline function.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
