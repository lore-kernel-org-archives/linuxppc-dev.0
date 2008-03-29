Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8CA6DDDF07
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2008 07:50:43 +1000 (EST)
Date: Sat, 29 Mar 2008 16:59:42 -0500
From: Olof Johansson <olof@lixom.net>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 6/9] [POWERPC] prpmc2800: clean up dts properties
Message-ID: <20080329215942.GB27226@lixom.net>
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234900.GF30214@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080328234900.GF30214@farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 04:49:00PM -0700, Dale Farnsworth wrote:
> From: Mark A. Greer <mgreer@mvista.com>
> 
> Remove several unused (or software config only) properties.
> Rename marvel node to "soc".  Technically, it's not an SOC,
> but its organization is the same as an SOC.  Also, rename the
> "block-index" property to "cell-index" to conform to current
> practice.

I see this rename as purely misleading. It isn't an soc, so it shouldn't
be named as such. Call it system-controller or something. Pretty much
any other name is better. :-)


-Olof
