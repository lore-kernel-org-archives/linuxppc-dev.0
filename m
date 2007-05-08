Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15C14DDE04
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 07:19:37 +1000 (EST)
Date: Wed, 9 May 2007 01:19:16 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] [POWERPC] 8xx: mpc885ads pcmcia support
Message-ID: <20070509011916.60853128@localhost.localdomain>
In-Reply-To: <774F0168-051E-4C6B-9292-8EE731E6D889@kernel.crashing.org>
References: <20070508095001.20018.85403.stgit@localhost.localdomain>
	<20070508095038.20018.60060.stgit@localhost.localdomain>
	<774F0168-051E-4C6B-9292-8EE731E6D889@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 May 2007 09:04:22 -0500
Kumar Gala wrote:

> > +			device_type = "pcmcia";
> > +			reg = <80 80>;
> > +			clock-frequency = <2faf080>;  
> 
> is the clock-freq fixed?
As I see now, that field is not really required as never extracted or used. The intention was to
use dts value iirc, later it was switched to ppc_proc_freq, but never removed from dts.

Hence I'll do that now.
-- 
Sincerely, Vitaly
