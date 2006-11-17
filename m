Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 7460367BEC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 15:11:48 +1100 (EST)
Date: Fri, 17 Nov 2006 05:11:46 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH] setup_kcore(): Fix incorrect function name in panic()
	call.
In-Reply-To: <200611171458.11245.jk@ozlabs.org>
Message-ID: <Pine.LNX.4.62.0611170506510.16998@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0611170446250.16998@pademelon.sonytel.be>
	<200611171458.11245.jk@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 17 Nov 2006, Jeremy Kerr wrote:
> 
> > -			panic("mem_init: kmalloc failed\n");
> > +			panic("setup_kcore: kmalloc failed\n");
> 
> How about:
> 	
> 	panic("%s: kmalloc_failed\n", __FUNCTION__);
> 
> To prevent this happening again?

You're right, thanks for the suggestion!

Gr{oetje,eeting}s,

						Geert

P.S. I was quite convinced panic() didn't do printf() style formatting, but
     apparently that's not (no longer?) true.
--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
