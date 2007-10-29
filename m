Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by ozlabs.org (Postfix) with ESMTP id 37188DE03A
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 02:37:12 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1134250nzh
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 08:37:10 -0700 (PDT)
Message-ID: <fa686aa40710290837k396737b1p80c562f20a4cc407@mail.gmail.com>
Date: Mon, 29 Oct 2007 09:37:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH v4.3] FEC - fast ethernet controller for mpc52xx
In-Reply-To: <4725AF08.6030309@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4713BA1C.2050604@pobox.com>
	<20071019112700.GD27403@nd47.coderock.org>
	<47206209.8080109@pobox.com>
	<20071025185706.29496.qmail@farnsworth.org>
	<20071025194114.GH3369@nd47.coderock.org>
	<20071025202908.GA2102@xyzzy.farnsworth.org>
	<20071026115909.GI3369@nd47.coderock.org>
	<20071026141828.GA14900@xyzzy.farnsworth.org>
	<20071026160749.GA21374@nd47.coderock.org>
	<4725AF08.6030309@garzik.org>
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/29/07, Jeff Garzik <jeff@garzik.org> wrote:
> Domen Puncer wrote:
> >  drivers/net/Kconfig           |   24
> >  drivers/net/Makefile          |    4
> >  drivers/net/fec_mpc52xx.c     | 1112 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/net/fec_mpc52xx.h     |  313 +++++++++++
> >  drivers/net/fec_mpc52xx_phy.c |  198 +++++++
> >  5 files changed, 1651 insertions(+)
>
> applied to #upstream-fixes
>
> it's not strictly a fix, but I did not want to hold this back until
> 2.6.25 either

Fantastic!  Thanks Jeff.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
