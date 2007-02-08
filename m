Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 13A49DDEB6
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 23:52:42 +1100 (EST)
Date: Thu, 8 Feb 2007 13:52:40 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: David Miller <davem@davemloft.net>
Subject: Re: checker-shell still hosed...
In-Reply-To: <Pine.LNX.4.62.0702081340340.28405@pademelon.sonytel.be>
Message-ID: <Pine.LNX.4.62.0702081351470.28405@pademelon.sonytel.be>
References: <20070208.030531.112264703.davem@davemloft.net>
	<20070208.041004.07457320.davem@davemloft.net>
	<20070208.041229.18308943.davem@davemloft.net>
	<Pine.LNX.4.62.0702081340340.28405@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 8 Feb 2007, Geert Uytterhoeven wrote:
> On Thu, 8 Feb 2007, David Miller wrote:
> > From: David Miller <davem@davemloft.net>
> > Date: Thu, 08 Feb 2007 04:10:04 -0800 (PST)
> > 
> > > Removing them makes the spaces go away.
> > 
> > FWIW, this patch below seems to fix the sparc64 build for me.
> > 
> > Paul, does it work for you on powerpc too?
> 
> Thx, it seems to build now. I'll tell you whether it boots on PS3 soon.

Build and boot were successful.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
