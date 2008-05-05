Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 8BA95DDE0D
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 06:44:15 +1000 (EST)
Date: Mon, 5 May 2008 22:44:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to link a .o with all modules
Message-ID: <20080505204449.GA9446@uranus.ravnborg.org>
References: <6C8AB345-2DA0-460D-B7C8-262463247DDE@kernel.crashing.org>
	<20080504192434.GA23752@uranus.ravnborg.org>
	<D346E2E4-26C3-482E-ABBF-AF1EE97E91CD@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D346E2E4-26C3-482E-ABBF-AF1EE97E91CD@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	lkml List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >
> >
> >Let me know if this does address your question.
> 
> The problem is MODPOST complains about undefined symbols:
> 
>   MODPOST 24 modules
> ERROR: "_restgpr_20_x" [net/key/af_key.ko] undefined!
> ERROR: "_restgpr_25_x" [net/key/af_key.ko] undefined!
> ERROR: "_restgpr_30_x" [net/key/af_key.ko] undefined!

I need a bit more context to try to analyse this.
Where did you expect _restgpr_20_x to be defined.
If in vmlinux then were they present in the
Module.symvers file?

If in the linked in .o file - could you
see the symbols using objdump.

etc.

Sorry - not much help right away.

PS. Travelling - do not expect responses until the
weekend.

	Sam
