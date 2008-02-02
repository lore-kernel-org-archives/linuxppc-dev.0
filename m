Return-Path: <dwm@enoyolf.org>
Received: from bebe.enoyolf.org (bebe.enoyolf.org [24.173.215.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bebe.enoyolf.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55F88DDECB
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 15:41:01 +1100 (EST)
In-reply-to: <20080201192344.GA4541@loki.buserror.net> 
References: <1201832451-23634-1-git-send-email-dwm@austin.ibm.com>
	<1201832451-23634-5-git-send-email-dwm@austin.ibm.com>
	<20080201192344.GA4541@loki.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/5] ehea: fix phyp checkpatch complaints 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2008 22:39:57 -0600
Message-ID: <19294.1201927197@bebe.enoyolf.org>
From: Doug Maxey <dwm@enoyolf.org>
Cc: Jan-Bernd Themann <themann@de.ibm.com>, netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@garzik.org>,
	Linux PowerPC List <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 01 Feb 2008 13:23:45 CST, Scott Wood wrote:
> On Thu, Jan 31, 2008 at 08:20:50PM -0600, Doug Maxey wrote:
> >  /* input param R5 */
> > -#define H_ALL_RES_QP_EQPO         EHEA_BMASK_IBM(9, 11)
...
> > +#define H_ALL_RES_QP_EQPO	  EHEA_BMASK_IBM(9, 11)
...
> 
> This was better the way it was (before, it was readable at any tab setting);
> checkpatch is overeager to complain on tab/space issues (it's a bit hard to
> distinguish indentation from alignment with a regex).

In emacs, with no special offsets, the lines appear to still line up.

What did happen was spaces were turned to tabs where applicable.

What editor shows a bad alignment?

++doug
