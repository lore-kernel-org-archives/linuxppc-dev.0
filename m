Return-Path: <diggskevin38@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 44BD5B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Mar 2011 06:38:14 +1100 (EST)
Received: by iym7 with SMTP id 7so3893037iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Mar 2011 11:38:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTimJwBfz=RksRtuj3M2VQoMjj1msUb78s1H=GfJM@mail.gmail.com>
References: <AANLkTimJwBfz=RksRtuj3M2VQoMjj1msUb78s1H=GfJM@mail.gmail.com>
Date: Sat, 12 Mar 2011 13:38:10 -0600
Message-ID: <AANLkTikKWrEqKH-4f2aMFnVUy-xCLnvxhtjF-pKUuC6e@mail.gmail.com>
Subject: Re: any chance to use a modern linux kernel on Pegasos1 G3 ?
From: kevin diggs <diggskevin38@gmail.com>
To: nello martuscielli <ppc.addon@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

For what it is worth, I can boot 2.6.36 on a PowerMac 8600 with a
750GX processor in it. I have to compile the kernel with gcc 4.1.2.
Figuring out why 4.3.5 won't work is ... a work in progress (maybe an
exorcism will help?).

kevin

On Sat, Mar 12, 2011 at 1:05 PM, nello martuscielli <ppc.addon@gmail.com> wrote:
> hallo dear linuxppc kernel developers,
>
> i'm looking for some tips to use a modern linux kernel on my old
> Pegasos1 G3 600MHz (IBM PowerPC 750Cxe).
> The last working one is 2.6.16.x with arch=ppc.
>
> a picture of the screen when it freezes loading a modern kernel:
> http://i52.tinypic.com/33uzgc8.jpg
>
>
> thank you,
> Nel
> --
> Power Mac G4 AGP 450MHz - CRUX PPC (32bit) 2.7
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
