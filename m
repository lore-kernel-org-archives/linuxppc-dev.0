Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DB77F2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 07:59:02 +1100 (EST)
Message-ID: <1357246738.2500.11.camel@pasglop>
Subject: Re: [PATCH] powerpc/pasemi: enable PRINTK_TIME in defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Date: Fri, 04 Jan 2013 07:58:58 +1100
In-Reply-To: <CAOesGMjE1xHVMwhA_Hv4BL5CGmuReuTTGmRfntmXQ5R90khSLA@mail.gmail.com>
References: <1353912688-6649-1-git-send-email-olof@lixom.net>
 <CAOesGMjE1xHVMwhA_Hv4BL5CGmuReuTTGmRfntmXQ5R90khSLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-01-03 at 12:54 -0800, Olof Johansson wrote:
> On Sun, Nov 25, 2012 at 10:51 PM, Olof Johansson <olof@lixom.net> wrote:
> > Enable PRINTK_TIME in pasemi_defconfig. Also regenerate it, it seems
> > that a lot of options have moved around since last time savedefconfig
> > was ran on it.
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> Ping?

I'm in the middle of harvesting stuff from patchwork for -next, this is one of them.

Cheers,
Ben.
