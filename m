Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 342DE1007D1
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 08:17:12 +1000 (EST)
Received: from mail171-va3 (localhost.localdomain [127.0.0.1])	by
	mail171-va3-R.bigfish.com (Postfix) with ESMTP id C68F5728117	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 22:17:08 +0000 (UTC)
Received: from VA3EHSMHS024.bigfish.com (unknown [10.7.14.245])	by
	mail171-va3.bigfish.com (Postfix) with ESMTP id AC7561B38046	for
	<linuxppc-dev@ozlabs.org>; Mon,  2 Aug 2010 22:17:08 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o72MGvCR023426	for
	<linuxppc-dev@ozlabs.org>; Mon, 2 Aug 2010 15:16:58 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o72MTg8E007440	for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Aug 2010 17:29:42 -0500 (CDT)
Date: Mon, 2 Aug 2010 17:16:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull my perf.git urgent branch
Message-ID: <20100802171654.1776759c@schlenkerla.am.freescale.net>
In-Reply-To: <20100728044731.GA2408@brick.ozlabs.ibm.com>
References: <20100727124019.GB14947@brick.ozlabs.ibm.com>
	<20100727112854.7bf97d48@schlenkerla.am.freescale.net>
	<20100728044731.GA2408@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Peter Zijlstra <peterz@infradead.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 28 Jul 2010 14:47:31 +1000
Paul Mackerras <paulus@samba.org> wrote:

> On Tue, Jul 27, 2010 at 11:28:54AM -0500, Scott Wood wrote:
> 
> > Doesn't the setting of .period need to be maintained (it is in the other
> > powerpc perf_event implementation that this is derived from)?
> 
> Gah, yes it does.

Well, looks like Linus pulled anyway...  I'll send a patch to
add .period.

-Scott
