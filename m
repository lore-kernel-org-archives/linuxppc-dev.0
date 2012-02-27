Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9A1BFB6FD2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2012 09:01:30 +1100 (EST)
Message-ID: <1330378346.11728.5.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc: Move GE GPIO and PIC drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martyn Welch <martyn.welch@ge.com>
Date: Tue, 28 Feb 2012 08:32:26 +1100
In-Reply-To: <4F4B8BB2.1060004@ge.com>
References: <1328614121-17803-1-git-send-email-martyn.welch@ge.com>
 <1328614121-17803-2-git-send-email-martyn.welch@ge.com>
 <1330299464.20389.58.camel@pasglop> <4F4B8BB2.1060004@ge.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wim Van Sebroeck <wim@iguana.be>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-02-27 at 13:57 +0000, Martyn Welch wrote:

> This patch (or one like it) has been around for a while now. Kumar wanted me
> to put them here rather than sysdev[1], but I'm easy either way.

Ah well, I disagree with Kumar here :-) One thing you can do is put all
your platforms files including the drivers in platforms/ge, that works
too. What I don't want is to have stray files at the top-level of
platforms.

> > Also, use git mv so that the file moves appear as such in the history,
> > this will make review easier by clearly separating the move from actual
> > changes to the files.
> > 
> 
> Hmm, thought I'd done that. Will try again.

Could be the way you exported the patch, I don't remember the git option
off the top of my head but there's a way to make it show the moves as
such.

Cheers,
Ben.
