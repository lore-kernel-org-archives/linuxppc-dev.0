Return-Path: <scottwood@freescale.com>
Message-ID: <460ACA0F.7090407@freescale.com>
Date: Wed, 28 Mar 2007 15:03:27 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: Patch: [PATCH 3/4] bootwrapper: no gzip fixes
References: <boot-3-03.miltonm@bga.com>
In-Reply-To: <boot-3-03.miltonm@bga.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> commit a9903811bf8d130a26004f9cb27b66513a267908 missed two uses of the
> the .gz suffix in the wrapper script and didn't clean the additonal
> possibly cached files.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
