Return-Path: <jwboyer@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.180])
	by ozlabs.org (Postfix) with ESMTP id 9DDA5DE010
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 07:47:36 +1100 (EST)
Received: by ik-out-1112.google.com with SMTP id c28so2175343ika.1
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 12:47:34 -0800 (PST)
Date: Thu, 8 Jan 2009 15:46:34 -0500
From: Josh Boyer <jwboyer@gmail.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: mal_probe crash
Message-ID: <20090108204634.GB2337@yoda.jdub.homelinux.org>
References: <20090107154434.0c9437ef@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090107154434.0c9437ef@lappy.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2009 at 03:44:34PM -0500, Sean MacLennan wrote:
>With Linus' latest git, mal_probe crashes. It calls netif_napi_add with
>the first parameter NULL. This was ok since the parameter, a net
>device, was only used if CONFIG_NETPOLL was set.
>
>Now it is always de-referenced. A quick check shows that ibm_newemac is
>the only driver that passed NULL as the first parameter to this call in
>2.6.28.
>
>I don't really follow ibm_newemac changes, so the patch may be waiting
>to be applied. This is really just a heads up.

I haven't heard of that, so I doubt there's a patch pending.  *Sigh*

josh
