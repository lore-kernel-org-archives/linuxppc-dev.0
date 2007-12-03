Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0FA04DDEB9
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 15:55:06 +1100 (EST)
Date: Sun, 2 Dec 2007 22:58:53 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [POWERPC] pasemi: Fix module information for gpio-mdio
Message-ID: <20071203045853.GB24492@lixom.net>
References: <20071203044016.GA24068@lixom.net>
	<18259.35370.588914.613689@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18259.35370.588914.613689@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 03, 2007 at 03:46:34PM +1100, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > Fix up the module information for gpio-mdio, it wouldn't load
> > because of lacking license, and wouldn't auto-load because of missing
> > MODULE_DEVICE_TABLE.
> 
> Needed for 2.6.24?

It's annoying but not critical, and the workaround is simple (build it
in). I've already queued it up in my for-2.6.25 git branch, that should
be sufficient.


Thanks,

Olof
