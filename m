Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 32407DDE28
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 05:38:50 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so768655ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Feb 2007 10:38:43 -0800 (PST)
Message-ID: <528646bc0702091038k5188d83fsbc088d875472791c@mail.gmail.com>
Date: Fri, 9 Feb 2007 11:38:42 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [RFC] mpc5200 device tree bindings refinement
In-Reply-To: <20070209173149.GA23362@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <11710062092006-git-send-email-grant.likely@secretlab.ca>
	<20070209173149.GA23362@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/9/07, Mark A. Greer <mgreer@mvista.com> wrote:
> On Fri, Feb 09, 2007 at 12:30:09AM -0700, Grant Likely wrote:
>
> Hi Grant,
>
> > Much needed refinement of mpc5200 device tree binding specifications.
> >
> > Short list:
>
> <snip>
>
> > - Specify reqiured 'cell-index' property to identify between multiple SOC
> >   devices of the same type.  (Useful for arbitrating shared register access)

Look here:
http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031093.html

and here:
http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031004.html
http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031060.html

I just used that same property name that Ben used for the EMAC to try
and establish some form of convention.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
