Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 885CAB7B74
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Nov 2009 01:13:37 +1100 (EST)
In-Reply-To: <4AFDB2BC.6020101@freescale.com>
References: <4AF99695.800@freescale.com>
	<OFDB4F927C.98657449-ONC125766A.006874A4-C125766A.00692F0B@transmode.se>
	<4AF9CC99.1030500@freescale.com>
	<OFDF13AF8E.1B38CEA9-ONC125766A.0073E59F-C125766A.0075ABE6@transmode.se>
	<4AF9DCE0.4030805@freescale.com>
	<OF15D21C1C.B7A920F0-ONC125766A.0076C36E-C125766A.0077B321@transmode.se>
	<4AF9E2E2.7030100@freescale.com> <4AF9F56E.9080104@freescale.com>
	<OF2843D474.207958C1-ONC125766A.00828F87-C125766B.00009091@transmode.se>
	<20091111152653.GA688@loki.buserror.net>
	<OFE47A9BB7.59140781-ONC125766C.00322B87-C125766C.003266AD@transmode.se>
	<4AFC65F7.4050600@freescale.com>
	<OFF2FA2BCA.A6C0CAA9-ONC125766C.0074494F-C125766C.0074AF53@transmode.se>
	<4AFC84E7.6050706@freescale.com>
	<OF9A8AE2F7.5F8AC107-ONC125766C.008051C5-C125766C.00810B6D@
	<4AFDB2BC.6020101@freescale.com>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF79BCADC7.9A687577-ONC125766E.004D3576-C125766E.004DF111@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 14 Nov 2009 15:11:19 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 13/11/2009 20:25:48:
>
> Joakim Tjernlund wrote:
> > Anyhow, lets start simple and just do the pinned ITLB so the
> > new TLB code can be applied. Can you confirm this works for you?
>
> It works (after changing #ifdef 1 to #if 1).

OK, new series sent.

BTW, one can probably avoid the extra space by the work around if the first
part(up to and including the insn check) is included in the DTLB error
and the second half is put just before the . = 0x2000, you would have to
use the self modifying variant though.
Not something I am going to play with.

 Jocke
