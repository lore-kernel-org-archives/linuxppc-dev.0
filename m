Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by ozlabs.org (Postfix) with ESMTP id B72B3DDFB1
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:56:33 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so2906093nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 08:56:29 -0700 (PDT)
Message-ID: <fa686aa40710020856x5faf2d82p281bb269286ba4c4@mail.gmail.com>
Date: Tue, 2 Oct 2007 09:56:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH 11/18] Virtex: Port UARTLITE driver to of-platform-bus
In-Reply-To: <87641p34dn.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181748.18608.62409.stgit@trillian.cg.shawcable.net>
	<87641p34dn.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/2/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> >>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:
>  Grant> +       pr_debug("uartlite: calling platform_driver_register()\n");
>  Grant> +       if ((ret = platform_driver_register(&ulite_platform_driver)) != 0)
>
> I prefer to not have assignments in the if ().

Already fixed in v3

> Are all the pr_debug necessary? It looks quite messy.

Maybe messy, but *very* useful.  Looks prettier in the v3 version with
the assignment and if() on separate lines.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
