Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E68AEB7B72
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 08:17:20 +1100 (EST)
Subject: Re: [PATCH 4/8] 8xx: Fixup DAR from buggy dcbX instructions.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4AD63F48.8030301@freescale.com>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091014172003.GD21215@loki.buserror.net>
	<OF64D89B73.6073827F-ONC125764F.00687BC4-C125764F.0068D4DC@transmode.se>
	<4AD62516.6090301@freescale.com>
	<OF22DCA2B2.1ADC3BC0-ONC125764F.006DE50F-C125764F.006E305A@transmode.se>
	<4AD63301.6090307@freescale.com>
	<OF459A0F65.D3201748-ONC125764F.00738958-C125764F.00744CF0@transmode.se>
	<4AD63F48.8030301@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Oct 2009 08:17:09 +1100
Message-Id: <1255555029.2347.55.camel@pasglop>
Mime-Version: 1.0
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

On Wed, 2009-10-14 at 16:14 -0500, Scott Wood wrote:
> 
> I think the last working version was a little older than that -- and it's quite 
> possible that there was underlying badness even earlier that just recently got 
> exposed.  I think I want to just debug it and find out what's really going on.

That would be good :-)

I've been itching to do that but without HW it's not trivial :-)

Cheers,
Ben.
