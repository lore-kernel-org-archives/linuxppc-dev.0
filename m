Return-Path: <amodra@gmail.com>
Received: from mail-pb0-x230.google.com (mail-pb0-x230.google.com
 [IPv6:2607:f8b0:400e:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A6A502C0135
 for <linuxppc-dev@ozlabs.org>; Mon, 13 May 2013 17:20:26 +1000 (EST)
Received: by mail-pb0-f48.google.com with SMTP id md4so1171728pbc.21
 for <linuxppc-dev@ozlabs.org>; Mon, 13 May 2013 00:20:21 -0700 (PDT)
Date: Mon, 13 May 2013 16:50:13 +0930
From: Alan Modra <amodra@gmail.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: provide __bswapdi2
Message-ID: <20130513072013.GD5221@bubble.grove.modra.org>
References: <1368220707.3378.57.camel@shinybook.infradead.org>
 <20130513164819.1c9331b9@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130513164819.1c9331b9@kryten>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
 viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 13, 2013 at 04:48:19PM +1000, Anton Blanchard wrote:
> On Fri, 10 May 2013 22:18:27 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > From: David Woodhouse <David.Woodhouse@intel.com>
> > 
> > Some versions of GCC apparently expect this to be provided by libgcc.
> 
> Thanks Dave. We were discussing this with Alan Modra and he doesn't
> think the 64bit target should ever emit a call to __bswapdi2. Did you
> only see it on 32bit, or 64bit as well?
> 
> Alan: I notice Dave is adding calls to __builtin_bswap, perhaps some
> versions of the 64bit compiler did emit __bswapdi2 calls for that.

I did a little digging, and it looks like gcc-4.4 will emit __bswapdi2
calls.  Support in rs6000.md appeared 2009-06-25.

-- 
Alan Modra
Australia Development Lab, IBM
