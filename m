Return-Path: <linus971@gmail.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 966A8B6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2012 16:03:06 +1100 (EST)
Received: by eeke50 with SMTP id e50so608783eek.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 22:03:02 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20120329154238.1ce219f7c998da45452af4b2@canb.auug.org.au>
References: <5599.1332958811@redhat.com> <30702.1332989444@neuling.org>
 <20120329135555.06593144b65bf81cc9191f8a@canb.auug.org.au>
 <20120329151544.ef2117821dfb459e8b52af48@canb.auug.org.au>
 <CA+55aFzn=bsH76hPDUgS-FBP=RVu51gwmRdqjkw5RJO=Q_cRfA@mail.gmail.com>
 <20120329154238.1ce219f7c998da45452af4b2@canb.auug.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Mar 2012 22:02:41 -0700
Message-ID: <CA+55aFzjQ7qb=bPAj_gGoGLPXOGweTaqtmOBZH4mUt8E_KQwsg@mail.gmail.com>
Subject: Re: [GIT PULL] Disintegrate and kill asm/system.h
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
 arnd@arndb.de, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, paul.gortmaker@windriver.com,
 hpa@zytor.com, akpm@linux-foundation.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 28, 2012 at 9:42 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> How about this (build tested on powerpc allyesconfig):

Looks better.

Grant - what's the plan about that CONFIG_VIRQ_DEBUG thing? In theory
something like it could be useful as a generic thing, but at least
right now it is clearly powerpc-specific (not just that the config
option only exists for powerpc: it has that whole
'powerpc_debugfs_root' thing in it)?

Stephen's patch very much looks like the right thing, but if there was
some plan to actually make this generic ...

                    Linus
