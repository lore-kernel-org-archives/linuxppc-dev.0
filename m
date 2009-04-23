Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7F351DDFAF
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 03:50:45 +1000 (EST)
Date: Thu, 23 Apr 2009 12:52:10 -0500
From: Olof Johansson <olof@lixom.net>
To: Mike Wolf <mjw@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: adjust oprofile_cpu_type
Message-ID: <20090423175210.GB4732@lixom.net>
References: <1240443612.27209.2.camel@mx3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1240443612.27209.2.camel@mx3>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2009 at 06:40:12PM -0500, Mike Wolf wrote:
> Resending.  the patch was munged last time.
> 
> 
> Oprofile is changing the naming it is using for the compatibility modes.
> Instead of having compat-power<x>, oprofile will go to family naming
> convention and use compat-v<x>.  Currently only compat-v1 will be
> defined.

Compat V1 of what? powerpc64? IBM powerpc64 PMC?  The performance
monitors are not architected, to give them a version number without
vendor information seems weird.

Also, doesn't this break compatibility with existing userspace tools?


-Olof
