Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D38FB7B81
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 09:22:38 +1100 (EST)
In-Reply-To: <1255296387.2192.43.camel@pasglop>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-6-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-7-git-send-email-Joakim.Tjernlund@transmode.se>	
	<1255278912-8042-8-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255296387.2192.43.camel@pasglop>
Subject: Re: [PATCH 7/8] 8xx: Restore _PAGE_WRITETHRU
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF0664CEC2.C4547EAA-ONC125764C.007ABA27-C125764C.007AD248@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 12 Oct 2009 00:21:32 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 11/10/2009 23:26:27:
>
> On Sun, 2009-10-11 at 18:35 +0200, Joakim Tjernlund wrote:
> > 8xx has not had WRITETHRU due to lack of bits in the pte.
> > After the recent rewrite of the 8xx TLB code, there are
> > two bits left. Use one of them to WRITETHRU.
> >
> > Perhaps use the last SW bit to PAGE_SPECIAL or PAGE_FILE?
>
> _PAGE_FILE can already overwrite other bits as it's only set
> when !present, and should pretty much always be 0x2

OK.

>
> I think I've replaced _PAGE_EXEC with _PAGE_SPECIAL already
> upstream since _PAGE_EXEC is unused on 8xx.

What is page SPECIAL anyway?
