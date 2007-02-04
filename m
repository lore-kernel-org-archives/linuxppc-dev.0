Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5FFA5DDE06
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 09:11:25 +1100 (EST)
Date: Sun, 4 Feb 2007 16:18:49 -0600
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] [1/9] pasemi: Default root device
Message-ID: <20070204221849.GA2862@lixom.net>
References: <20070202045448.145851000@lixom.net>>
	<20070202045507.589087000@lixom.net>>
	<45C3BB0A.1020307@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45C3BB0A.1020307@am.sony.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 02, 2007 at 02:28:26PM -0800, Geoff Levand wrote:
> Olof Johansson wrote:
> > Set up default root device on the pasemi platform.
> > +	if (ROOT_DEV == 0) {
> > +#ifdef  CONFIG_ROOT_NFS
> > +		ROOT_DEV = Root_NFS;
> > +#else
> > +		ROOT_DEV = Root_SDA1;
> > +#endif
> 
> Christoph told me these are no longer desired in new
> platform code.

What's no longer desired, the logic trying to figure out if NFS is the
root, or setting a platform-specific root device if none is specified
already?


-Olof
