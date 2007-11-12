Return-Path: <stern@rowland.harvard.edu>
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by ozlabs.org (Postfix) with SMTP id 2FBABDDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 06:59:27 +1100 (EST)
Date: Mon, 12 Nov 2007 14:52:46 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] Re: [RFC] powermac: proper sleep management
In-Reply-To: <1194885177.5229.45.camel@johannes.berg>
Message-ID: <Pine.LNX.4.44L0.0711121451210.1567-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-pm <linux-pm@lists.linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 12 Nov 2007, Johannes Berg wrote:

> > Looks good to me, +/- a couple of things:
> > 
> >  - We _REALLY_ want the freezer to be optional and not enabled by
> > default on PowerPC. Maybe make it a compile option ?
> 
> Well, Alan is going to tell you that USB will break. If we need
> confirmation for that I can do the test he suggested to you or Paul a
> while ago.

Isn't it true that the freezer _already_ isn't enabled on PPC?  So 
leaving it off wouldn't break anything more than it is broken now.

Alan Stern
