Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 22 Jan 2009 03:32:31 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] PS3 ps3av_set_video_mode() make id signed
In-Reply-To: <4975F455.8020004@gmail.com>
Message-ID: <alpine.LRH.2.00.0901220331390.16811@vixen.sonytel.be>
References: <4972456C.1050301@gmail.com>
	<alpine.LRH.2.00.0901201018440.31271@vixen.sonytel.be>
	<4975F455.8020004@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 20 Jan 2009, Roel Kluin wrote:
> >> make id signed so a negative id will get noticed
> > 
> > Thanks for noticing! It looks OK, except...
> 
> > 1. You forgot to update the forward declaration of ps3av_set_video_mode() in
> >    arch/powerpc/include/asm/ps3av.h (did you compile this succesfully?)
> 
> fixed that (and no, sorry, I didn't compile test it, I have to focus a bit on
> a biotechnology exam, maybe later).
> 
> > 2. You forgot to change `u32 id' in ps3av_probe().
> 
> ok, changed it. but I am not sure whether the last two hunks are ok. Should
> we error out like this or just let the negative value be assigned to
> ps3av->ps3av_mode? If not, is there more cleanup required?

I'll look into it and will take further care of it...

> 
> > Can you please make these changes, too? Thx again!
> 
> No problem.
> 
> --------------------->8-------------------------8<------------------------
> Make id signed so a negative id will get noticed. Error out if
> ps3av_auto_videomode() fails.

Thanks again!

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
