Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCgdq5cHhzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 11:18:07 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 22 May 2016 19:18:04 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Andrea Gelmini <andrea.gelmini@gelma.net>, andrea.gelmini@gelma.net
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, trivial@kernel.org,
 pawel.moll@arm.com, devicetree@hellion.org.uk, sudeep.holla@arm.com,
 paulus@samba.org, galak@codeaurora.org, dt@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0030/1529] Fix typo
In-Reply-To: <20160521113934.453-1-andrea.gelmini@gelma.net>
References: <20160521113934.453-1-andrea.gelmini@gelma.net>
Date: Mon, 23 May 2016 11:17:51 +1000
Message-ID: <878tz1y3ls.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrea Gelmini <andrea.gelmini@gelma.net> writes:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  Documentation/devicetree/bindings/rtc/rtc-opal.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-opal.txt b/Documentation/devicetree/bindings/rtc/rtc-opal.txt
> index a1734e5..2340938c 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-opal.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-opal.txt
> @@ -2,7 +2,7 @@ IBM OPAL real-time clock
>  ------------------------
>  
>  Required properties:
> -- comapatible: Should be "ibm,opal-rtc"
> +- compatible: Should be "ibm,opal-rtc"
>  
>  Optional properties:
>  - wakeup-source: Decides if the wakeup is supported or not

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
