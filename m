Return-Path: <tnt@246tNt.com>
Received: from mailrelay009.isp.belgacom.be (mailrelay009.isp.belgacom.be
	[195.238.6.176]) by ozlabs.org (Postfix) with ESMTP id E460ADDEF0
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 17:28:55 +1000 (EST)
Message-ID: <49F801AF.1060404@246tNt.com>
Date: Wed, 29 Apr 2009 09:28:47 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: Update MPC5xxx and Xilinx Virtex maintainer
	entries
References: <20090428165015.1410.47926.stgit@localhost.localdomain>
In-Reply-To: <20090428165015.1410.47926.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> - Add git tree URLs
> - Drop Sylvain from the 5xxx maintainers list.  He hasn't been active
>   for a while now.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Confirmed.

> ---
> 
>  MAINTAINERS |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef03abe..4a8d367 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3434,11 +3434,10 @@ L:	linuxppc-dev@ozlabs.org
>  S:	Maintained
>  
>  LINUX FOR POWERPC EMBEDDED MPC5XXX
> -P:	Sylvain Munaut
> -M:	tnt@246tNt.com
>  P:	Grant Likely
>  M:	grant.likely@secretlab.ca
>  L:	linuxppc-dev@ozlabs.org
> +T:	git git://git.secretlab.ca/git/linux-2.6.git
>  S:	Maintained
>  
>  LINUX FOR POWERPC EMBEDDED PPC4XX
> @@ -3456,6 +3455,7 @@ P:	Grant Likely
>  M:	grant.likely@secretlab.ca
>  W:	http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex
>  L:	linuxppc-dev@ozlabs.org
> +T:	git git://git.secretlab.ca/git/linux-2.6.git
>  S:	Maintained
>  
>  LINUX FOR POWERPC EMBEDDED PPC8XX
> 
