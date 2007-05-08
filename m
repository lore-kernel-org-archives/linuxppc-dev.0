Return-Path: <vitb@kernel.crashing.org>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 83672DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 02:20:07 +1000 (EST)
Date: Tue, 8 May 2007 20:19:59 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 8xx: PQ SoC IRDA support
Message-ID: <20070508201959.339aca59@vitb.ru.mvista.com>
In-Reply-To: <522959B8-DDF1-4AA1-87AE-336793EDA181@kernel.crashing.org>
References: <20070508013044.6407.20509.stgit@localhost.localdomain>
	<522959B8-DDF1-4AA1-87AE-336793EDA181@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Samuel Ortiz <samuel@sortiz.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 May 2007 08:33:19 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> > +			scc@a20 {
> > +				device_type = "network";
> > +				compatible = "fsl,irda";  
> 
> is this specific enough?  52xx also has irda and I'm guessing they'd  
> require different drivers (haven't looked).
Yap, I'll do "fsl,pq-irda" here...

-- 
Sincerely, 
Vitaly
