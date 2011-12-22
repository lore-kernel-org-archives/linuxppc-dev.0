Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DEB0BB719F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2011 05:01:50 +1100 (EST)
Received: by wgbds13 with SMTP id ds13so13058840wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2011 10:01:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1324570881-11503-1-git-send-email-Kyle.D.Moffett@boeing.com>
References: <1324570881-11503-1-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Thu, 22 Dec 2011 13:01:45 -0500
Message-ID: <CA+5PVA7ZzDEsLrN_W=fo_GzSwV4Nj7KBT7zJRoVs0b4TcZvwBQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/currituck: Fix up missing MPIC_PRIMARY flag
From: Josh Boyer <jwboyer@gmail.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 22, 2011 at 11:21 AM, Kyle Moffett
<Kyle.D.Moffett@boeing.com> wrote:
> The 44x/currituck platform didn't get updated when the MPIC code
> inverted the flag from MPIC_PRIMARY =3D> !MPIC_SECONDARY. =A0Fix it up.
>
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>

I already included this fixup in my 4xx tree 'next' branch.  A pull
request was sent to Ben as well.

http://git.infradead.org/users/jwboyer/powerpc-4xx.git/commitdiff/eb975652b=
8fa0c4f08a52744d34bdebf66589d4b

josh
