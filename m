Return-Path: <linus971@gmail.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 480A82C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 12:04:56 +1000 (EST)
Received: by wibhm4 with SMTP id hm4so2444794wib.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 19:04:52 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <3BDA9E62-7031-42D6-8CA9-5327B61700F5@suse.de>
References: <3BDA9E62-7031-42D6-8CA9-5327B61700F5@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Sep 2012 19:04:32 -0700
Message-ID: <CA+55aFyXwB1QcXE4Z_FAGnXROSgvP2x2+wjnX9OWPa4Dfaaf0A@mail.gmail.com>
Subject: Re: [REGRESSION] nfsd crashing with 3.6.0-rc7 on PowerPC
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-nfs@vger.kernel.org, skinsbursky@parallels.com,
 LKML List <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
 bfields@redhat.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 27, 2012 at 6:55 PM, Alexander Graf <agraf@suse.de> wrote:
>
> Below are OOPS excerpts from different rc's I tried. All of them crashed - all the way up to current Linus' master branch. I haven't cross-checked, but I don't remember any such behavior from pre-3.6 releases.

Since you seem to be able to reproduce it easily (and apparently
reliably), any chance you could just bisect it?

Since I assume v3.5 is fine, and apparently -rc1 is already busted, a simple

   git bisect start
   git bisect good v3.5
   git bisect bad v3.6-rc1

will get you started on your adventure..

          Linus
