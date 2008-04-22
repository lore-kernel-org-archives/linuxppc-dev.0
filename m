Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8EC2EDDE23
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 23:18:50 +1000 (EST)
Date: Tue, 22 Apr 2008 08:31:20 -0500
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 04/11] Convert from DBG() to pr_debug() in
	platforms/pseries/setup.c
Message-ID: <20080422133120.GA8338@lixom.net>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
	<6112063f5eac0a820949415417d49a5376ad5ffd.1208505275.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6112063f5eac0a820949415417d49a5376ad5ffd.1208505275.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2008 at 05:54:36PM +1000, Michael Ellerman wrote:
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

I know it's fun to see yourself in the changeset statistics, but this is
silly. Please bake together all the simple changes to one patch instead
of one per file. They are all trivial.


-Olof
