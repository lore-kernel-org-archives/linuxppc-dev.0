Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id C70D8DDF53
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 13:53:23 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so2293ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Apr 2007 20:53:22 -0700 (PDT)
Message-ID: <528646bc0704302053w6c2a39b9t1b7b57d535950886@mail.gmail.com>
Date: Mon, 30 Apr 2007 21:53:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "John Williams" <jwilliams@itee.uq.edu.au>
Subject: Re: [RFC] SystemACE driver - abstract register ops
In-Reply-To: <4636B71D.3040601@itee.uq.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <463199EF.3090900@itee.uq.edu.au>
	<528646bc0704270031w5c9966f8tc3a5e5292df10a35@mail.gmail.com>
	<4636B71D.3040601@itee.uq.edu.au>
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>, Stefan Roese <sr@denx.de>,
	Rick Moleres <rick.moleres@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/30/07, John Williams <jwilliams@itee.uq.edu.au> wrote:
> Grant,
>
> Grant Likely wrote:
> > Very cool; I hope it works well.
>
> Indeed it does - your latest patchset version of the systemACE driver
> "just works" on MicroBlaze 2.6.20
>
> Acked-by: John Williams <jwilliams@itee.uq.edu.au>

Wonderful, thanks John.  I've got a few last little details that I'm
going to try and get sorted out in the next 24 hours or so, and then
I'll post the driver to the lkml.  If things go really well, it might
even get picked up for 2.6.22.  I'll make sure to CC you when I send
it.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
