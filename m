Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao02.cox.net (fed1rmmtao02.cox.net [68.230.241.37])
	by ozlabs.org (Postfix) with ESMTP id 982B067A6E
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 10:47:12 +1100 (EST)
Date: Thu, 20 Jan 2005 16:47:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050120234708.GF2626@smtp.west.cox.net>
References: <20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
	<20050118181330.GJ28724@smtp.west.cox.net>
	<41ED5C51.8020809@mvista.com>
	<20050118190848.GM28724@smtp.west.cox.net>
	<41ED66D0.2090506@mvista.com>
	<20050119180841.GP28724@smtp.west.cox.net>
	<41F01A23.2090907@mvista.com>
	<20050120225321.GB2626@smtp.west.cox.net>
	<41F03CEA.2030703@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41F03CEA.2030703@mvista.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 20, 2005 at 04:21:14PM -0700, Mark A. Greer wrote:
> Tom Rini wrote:
> 
> >Why ask the user for something you know he wants?  If they've selected
> >GENRTC and are using the board, they'll probably want GENRTC to work.
> >It's exactly what you described except the user won't have to know about
> >anything going on.
> 
> If that's the way you want to go then it should depend on having the rtc 
> "driver" selected and rtc.h should look something like:

I don't know how we talked past eachother, but it would look exactly
like it did in your patch.  The only thing is that you don't ask the
user, you make use of what the user told you already.  This is a nice
new feature of the 2.6 kconfig system.  This is what I'm asking you to
change from your first patch.

-- 
Tom Rini
http://gate.crashing.org/~trini/
