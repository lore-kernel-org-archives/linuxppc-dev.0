Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DFAAEB71BD
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Oct 2011 03:51:54 +1100 (EST)
In-Reply-To: <39B024CE-70A2-4D32-A29C-5702C7D2D6CF@digitaldans.com>
References: <1318246714-5015-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <39B024CE-70A2-4D32-A29C-5702C7D2D6CF@digitaldans.com>
Subject: Re: [PATCH 0/3] 8xx: Large page(8MB) support for 2.4
To: Dan Malek <ppc6dev@digitaldans.com>
Message-ID: <OFAF68F93F.57D058F1-ONC1257925.005B7C6F-C1257925.005C10D7@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 10 Oct 2011 18:45:36 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Willy Tarreau <w@1wt.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dan Malek <ppc6dev@digitaldans.com> wrote on 2011/10/10 18:22:09:
>
>
> Hi Joakim.
>
> On Oct 10, 2011, at 4:38 AM, Joakim Tjernlund wrote:
>
> > This adds Large page support for 8xx and uses it
> > for all kernel RAM....
>
> > - Dan, what do you think :)
>
> Since you asked, yes it looks great :-)  Now, can we
> get this into a more contemporary kernel?  I'm
> actually working on an 8xx project that may have
> a few years of life left.

That is an easy port but I will have to do that blind. Would you
mind take this for a spin on 2.4 first?

The more interesting part is if one should use other sized(16K or 512K) large pages too?
Those should be useful for user space but it is a lot of work. I haven't checked
what large page support for user space is in 2.6 for ppc though.

 Jocke
