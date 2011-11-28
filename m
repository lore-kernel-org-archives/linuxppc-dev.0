Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 277C1B6F95
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 11:15:16 +1100 (EST)
Message-ID: <1322439281.23348.34.camel@pasglop>
Subject: Re: [PATCH v9 11/13] powerpc: select HAVE_SECCOMP_FILTER and
 provide seccomp_execve
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Will Drewry <wad@chromium.org>
Date: Mon, 28 Nov 2011 11:14:41 +1100
In-Reply-To: <1314682083.2488.73.camel@pasglop>
References: <1308875813-20122-1-git-send-email-wad@chromium.org>
 <1308875813-20122-11-git-send-email-wad@chromium.org>
 <1314682083.2488.73.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: fweisbec@gmail.com, scarybeasts@gmail.com, djm@mindrot.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, jmorris@namei.org,
 torvalds@linux-foundation.org, kees.cook@canonical.com,
 Paul Mackerras <paulus@samba.org>, mingo@elte.hu, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, segoon@openwall.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-08-30 at 15:28 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2011-06-23 at 19:36 -0500, Will Drewry wrote:
> > Facilitate the use of CONFIG_SECCOMP_FILTER by wrapping compatibility
> > system call numbering for execve and selecting HAVE_SECCOMP_FILTER.
> > 
> > v9: rebase on to bccaeafd7c117acee36e90d37c7e05c19be9e7bf
> > 
> > Signed-off-by: Will Drewry <wad@chromium.org>
> 
> Seen these around for a while ... :-)
> 
> I don't see a harm in the patches per-se tho I haven't reviewed the
> actual seccomp filter stuff and it's good (or bad) behaviour on ppc.

Did that stuff every got anywhere ? I don't see HAVE_SECCOMP_FILTER
upsteam ... should I just drop the powerpc patch from patchwork ?

Cheers,
Ben.
