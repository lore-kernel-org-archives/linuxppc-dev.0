Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 70504DDF00
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Mar 2008 07:48:54 +1000 (EST)
Date: Sat, 29 Mar 2008 16:57:53 -0500
From: Olof Johansson <olof@lixom.net>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH 4/9] [POWERPC] mv64x60: Fix FDT compatible names:
	mv64x60 => mv64360
Message-ID: <20080329215753.GA27226@lixom.net>
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234704.GD30214@farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080328234704.GD30214@farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 04:47:04PM -0700, Dale Farnsworth wrote:
> From: Mark A. Greer <mgreer@mvista.com>
> 
> Compatible names should refer to a specific version of the hardware,
> without wildcards.  Change each instance of mv64x60 to mv64360, which
> is the oldest version we currently support.

Actually, it's normal to have more than one compatible field, from
specific to generic. So it should make sense to have both (with the
64360 entry first).


-Olof
