Return-Path: <dmitry.torokhov@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 781F8DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 00:25:27 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so982121nfd
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 05:25:25 -0800 (PST)
Message-ID: <d120d5000711160525p225f4b4o30eab6d01b289cda@mail.gmail.com>
Date: Fri, 16 Nov 2007 08:25:24 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Subject: Re: [PATCH] remove dead MAC_ADBKEYCODES
In-Reply-To: <Pine.LNX.4.62.0711161043560.29012@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1195142010.14001.21.camel@hammer.suse.cz>
	<Pine.LNX.4.62.0711161043560.29012@pademelon.sonytel.be>
Cc: Stanislav Brabec <sbrabec@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 16, 2007 4:44 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Wrong mailing list ;-)
>
> On Thu, 15 Nov 2007, Stanislav Brabec wrote:
> > It seems, that current kernel source code contains no traces of
> > MAC_ADBKEYCODES and no reference to keyboard_sends_linux_keycodes any
> > more.
> >
> > Attached patch removes them from configuration files.
> >
> > Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
>
> Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
>

Geert, are you going to push it through your tree?

-- 
Dmitry
