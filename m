Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 273C467BD2
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 04:21:40 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1975207ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Aug 2006 11:21:38 -0700 (PDT)
Message-ID: <528646bc0608021121l124cd3e8i14dfdfbf40272193@mail.gmail.com>
Date: Wed, 2 Aug 2006 12:21:37 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: RFC: Location for Device Tree Sources?
In-Reply-To: <20060802182319.GI17652@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
	<20060802182319.GI17652@mag.az.mvista.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/2/06, Mark A. Greer <mgreer@mvista.com> wrote:
> On Tue, Aug 01, 2006 at 09:20:52PM -0600, Grant Likely wrote:
> > I have to second that opinion.  The device tree is absolutely integral
> > with the rest of the code/drivers needed to support a board.  I say
> > there are stronger arguments for keeping the dts files in the kernel
> > source than there are for the boot wrapper.
>
> Well, the dts is no good to you without dtc so do we put dtc in the
> kernel source tree too?

I don't know; should we include gcc also?

:p


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
