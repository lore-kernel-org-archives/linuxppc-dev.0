Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Remove obsolete check_properties() function 
In-Reply-To: Your message of "Thu, 06 Dec 2007 17:04:04 +1100."
	<20071206060404.GF19927@localhost.localdomain>
References: <20071206060404.GF19927@localhost.localdomain> 
Date: Thu, 06 Dec 2007 09:21:01 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1J0IX7-00058W-TA@jdl.com>
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
> After the last couple of patches converting various old-style semantic
> checks to the new framework, the only thing that the old-style
> check_properties() function still checks is that the size of "reg"
> properties is a multiple of the cell size.
> 
> This patch removes check_properties() and all related code and data.
> The check on the size of reg properties is folded into the existing
> check for the format of "reg" properties (still old-style for the time
> being).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
