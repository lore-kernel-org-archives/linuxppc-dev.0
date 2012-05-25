Return-Path: <alexdeucher@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBA46B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2012 01:06:27 +1000 (EST)
Received: by qcha6 with SMTP id a6so637312qch.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2012 08:06:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FBDD2CF.5060008@mentor.com>
References: <4FBDD2CF.5060008@mentor.com>
Date: Fri, 25 May 2012 11:06:23 -0400
Message-ID: <CADnq5_MFu8Z0aLON9ohr0gFLLoCVwB3oppxsiON6gk-W2-49NA@mail.gmail.com>
Subject: Re: Oops with Radeon/Uninorth on Maple
From: Alex Deucher <alexdeucher@gmail.com>
To: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul@freedesktop.org, Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 =?ISO-8859-1?Q?Michel_D=E4nzer?= <daenzer@vmware.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 24, 2012 at 2:18 AM, Dmitry Eremin-Solenikov
<dmitry_eremin@mentor.com> wrote:
> Hello, colleagues,
>
> I'm trying to enable an AGP slot (again) on my Maple board (dual PPC970FX
> board, with CPC925 (U3H) north bridge).
>
> =A0For now I'm stuck with a problem: I use radeon card, drm-radeon driver=
 with
> KMS.
>
> If I force drm-radeon to think about a card as about PCI card (by comment=
ing
> corresponding lines in drm_radeon_kms.c), everything works, I get
> framebuffer, working X11, etc. If I enable agpgart-uninorth driver
> and RADEON_IS_AGP flag in drm driver, I get an Oops early during the
> bootstrap. Relevant part of the log (I can send full dmesg of normal
> bootstrap or this oops on request, if that would help).

For future reference, you can disable AGP by loading radeon with the
agpmode parameter set to -1, e.g., radeon.agpmode=3D-1

No need to edit the source.

Alex
