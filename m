Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: data.c doesn't need to include dtc-parser.tab.h 
In-Reply-To: Your message of "Mon, 22 Oct 2007 14:09:23 +1000."
	<20071022040923.GA21138@localhost.localdomain>
References: <20071022040923.GA21138@localhost.localdomain> 
Date: Mon, 22 Oct 2007 11:39:25 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ik0JK-0002zG-0k@jdl.com>
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
> Presumably we used this #include once, but it's certainly not
> necessary now.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
