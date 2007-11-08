Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [2/2] dtc: Make -Idts -Odts preserve property-internal labels 
In-Reply-To: Your message of "Wed, 07 Nov 2007 10:22:25 +1100."
	<20071106232225.GI31367@localhost.localdomain>
References: <20071106232120.GH31367@localhost.localdomain>
	<20071106232225.GI31367@localhost.localdomain>
Date: Thu, 08 Nov 2007 09:25:40 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Iq9GG-0002fu-Pe@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> This patch changes -Odts mode output so that labels within property
> values in the input are preserved in the output.  Applied on top of
> the earlier patch to preserve node and property labels in -Odts mode,
> this means that dtc in -Idts -Odts mode will transfer all labels in
> the input to the output.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
