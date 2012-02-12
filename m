Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41451B6FA1
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Feb 2012 01:04:40 +1100 (EST)
Received: by wibhm4 with SMTP id hm4so3082650wib.15
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Feb 2012 06:04:36 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1329055329-11897-1-git-send-email-geert@linux-m68k.org>
References: <1329055329-11897-1-git-send-email-geert@linux-m68k.org>
Date: Sun, 12 Feb 2012 15:04:35 +0100
Message-ID: <CAMuHMdX7VM1NXx6+50xkOEUSRi40sBdqWJAu4RU2+k4X1m_+Tw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.3-rc3
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Feb 12, 2012 at 15:02, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
> JFYI, when comparing v3.3-rc3 to v3.3-rc2[3], the summaries are:
> =C2=A0- build errors: +12/-8
> =C2=A0- build warnings: +53/-67

Of these 11 are powerpc-related:

   + arch/powerpc/platforms/512x/mpc512x_shared.c: error:
'FSL_DIU_PORT_DVI' undeclared (first use in this function):  =3D> 189:9
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: 'enum
fsl_diu_monitor_port' declared inside parameter list:  =3D> 70:9, 84:9,
88:36
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: 'return' with
a value, in function returning void:  =3D> 189:2
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: function
declaration isn't a prototype:  =3D> 69:5, 88:6, 83:6, 187:1
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: its scope is
only this definition or declaration, which is probably not what you
want:  =3D> 70:9
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: parameter 1
('port') has incomplete type:  =3D> 187:54, 83:56, 88:57, 69:56
  + arch/powerpc/platforms/512x/mpc512x_shared.c: error: return type
is an incomplete type:  =3D> 187:1
  + arch/powerpc/sysdev/mv64x60_dev.c: error: assignment makes pointer
from integer without a cast:  =3D> 253:11
  + arch/powerpc/sysdev/mv64x60_dev.c: error: implicit declaration of
function 'of_get_mac_address':  =3D> 253:2
  + arch/powerpc/sysdev/tsi108_dev.c: error: assignment makes pointer
from integer without a cast:  =3D> 108:12
  + arch/powerpc/sysdev/tsi108_dev.c: error: implicit declaration of
function 'of_get_mac_address':  =3D> 108:3

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
