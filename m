Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id DD55FDDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 00:31:42 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so179156rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 07:31:41 -0700 (PDT)
Message-ID: <fa686aa40709190731y3aca963bx1e148ba5b94f0094@mail.gmail.com>
Date: Wed, 19 Sep 2007 08:31:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "S. Fricke" <silvio.fricke@gmail.com>
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
In-Reply-To: <20070919071643.GE5682@sfrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070906133050.GE11807@sfrouter> <20070911124154.GI11807@sfrouter>
	<fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>
	<20070911182811.GA3582@sfrouter>
	<fa686aa40709111205n5d9f9654m6f2b96d468dfd017@mail.gmail.com>
	<20070912183038.GA5682@sfrouter>
	<fa686aa40709121229h6bb2902etffcd197e2e5af722@mail.gmail.com>
	<20070919071643.GE5682@sfrouter>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/19/07, S. Fricke <silvio.fricke@googlemail.com> wrote:
> OK, my dts is now:
>
>     / {
>         /* ... */
>         soc5200@f0000000 {
>             /* ... */
>             intpin@0 {
>                 interrupt-parent = <500>;
>                 interrupts = <1 2 2>;
>             };
>             /* ... */
>         };
>         /* ... */
>     };

Note: your intpin node does not (and probably should not) need to be a
child of the soc node.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
