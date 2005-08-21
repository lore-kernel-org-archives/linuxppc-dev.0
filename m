Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3E9767FAC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Aug 2005 10:01:00 +1000 (EST)
Date: Sun, 21 Aug 2005 20:55:25 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20050821235524.GE6746@dmt.cnet>
References: <43062C9D.5060703@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43062C9D.5060703@ru.mvista.com>
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx pq platform system descriptions
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Aug 19, 2005 at 11:01:49PM +0400, Vitaly Bordug wrote:
> Added ppc_sys device and system definitions for PowerQUICC I devices.
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> -- 
> Sincerely,
> Vitaly

Vitaly, Kumar,

Have a few questions:

- Do you have any plans on actually using device model information by
drivers (as was done in the mpc8xxx/gianfar) on m8xx? Its not very clear
to me what are the the practical advantages of that?

- I don't know whether its possible to retrieve 8xx CPUID information
(if there is any). Can't find anything in the manual.
