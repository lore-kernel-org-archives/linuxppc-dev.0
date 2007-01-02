Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id DD751DE03D
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jan 2007 10:04:55 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1688399ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Jan 2007 15:04:54 -0800 (PST)
Message-ID: <528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>
Date: Tue, 2 Jan 2007 16:04:53 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
In-Reply-To: <1167775493.3660.23.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166522096.25827.76.camel@pmac.infradead.org>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
	<1166538553.25827.99.camel@pmac.infradead.org>
	<1166558300.19254.71.camel@localhost.localdomain>
	<1167773388.22068.443.camel@pmac.infradead.org>
	<1167773863.6165.82.camel@localhost.localdomain>
	<1167775493.3660.23.camel@shinybook.infradead.org>
Cc: Paul Mackerras <paulus@samba.org>, bbrv@genesi-usa.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/2/07, David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2007-01-03 at 08:37 +1100, Benjamin Herrenschmidt wrote:
> > Ok. Well, Nicolas Det have unfortunately repeately said "we won't fix
> > the firmware"
>
> Really? Why on earth not? We're talking about simple and obvious fixes,
> and we have no reason to keep it broken for "compatibility", surely?

Really don't know, especially considering that the firmware did get
changed during the whole process to modify the irq mapping format.

Cheers,
g.
