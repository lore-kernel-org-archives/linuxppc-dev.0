Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4FA6EB7B88
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 09:45:39 +1100 (EST)
Subject: Re: [PATCH 7/8] 8xx: Restore _PAGE_WRITETHRU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF0664CEC2.C4547EAA-ONC125764C.007ABA27-C125764C.007AD248@transmode.se>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-5-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-6-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-7-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-8-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255296387.2192.43.camel@pasglop>
	<OF0664CEC2.C4547EAA-ONC125764C.007ABA27-C125764C.007AD248@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Oct 2009 09:45:30 +1100
Message-Id: <1255301130.2192.45.camel@pasglop>
Mime-Version: 1.0
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

On Mon, 2009-10-12 at 00:21 +0200, Joakim Tjernlund wrote:
> > I think I've replaced _PAGE_EXEC with _PAGE_SPECIAL already
> > upstream since _PAGE_EXEC is unused on 8xx.
> 
> What is page SPECIAL anyway? 

It's used on newer kernels to indicates PTEs that map something that
isn't backed by a struct page (ie, not memory)

Cheers,
Ben.
