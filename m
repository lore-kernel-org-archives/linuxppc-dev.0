Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 2C5F1DDEFA
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 06:20:03 +1100 (EST)
Date: Tue, 6 Mar 2007 20:19:58 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Edward Strong <edo@onkeh.net>
Subject: Re: Updated ps3fb usage?
In-Reply-To: <29902.81.170.115.218.1173205803.squirrel@onkeh.net>
Message-ID: <Pine.LNX.4.62.0703062016450.4463@pademelon.sonytel.be>
References: <29902.81.170.115.218.1173205803.squirrel@onkeh.net>
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

On Tue, 6 Mar 2007, Edward Strong wrote:
> Hi, I've just done a pull on Geoff's PS3 kernel git and I've noticed you
> can't change the videomode as a kernel parameter in kboot.conf anymore. 
> Has this feature been modified or removed completely?  I only ask because
> I seem to be stuck in an unusable video mode at boot.

I modified ps3fb to support the standard fbdev modedb framework, so you should
be able to say e.g. `video=720p' or `video=ps3fb:720p' now.

It should still work the old way (`video=ps3fb:mode:%u'), though (I'll give it
a try when I get back to the office).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
