Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18407.22329.130304.645554@cargo.ozlabs.ibm.com>
Date: Mon, 24 Mar 2008 18:24:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] mpc5200: fix incorrect compatible string for the
	mdio node
In-Reply-To: <1206156315-4734-1-git-send-email-grant.likely@secretlab.ca>
References: <1206156315-4734-1-git-send-email-grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely writes:

> The MDIO node in the lite5200b.dts file needs to also claim compatibility
> with the older mpc5200 chip.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> Paul, this one should also go in for .26

OK, I'll put it in the powerpc-next branch.  Or did you mean it should
go in .25?

Paul.
