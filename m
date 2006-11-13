Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 4CA9F67E7D
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 08:41:40 +1100 (EST)
Date: Mon, 13 Nov 2006 14:41:49 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [PATCH] make git ignore new wrapper generated files
Message-ID: <20061113214149.GA9157@mag.az.mvista.com>
References: <20061110180830.419c28bd.kim.phillips@freescale.com>
	<1163451020.5463.10.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1163451020.5463.10.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 13, 2006 at 02:50:20PM -0600, Matthew McClintock wrote:
> On Fri, 2006-11-10 at 18:08 -0600, Kim Phillips wrote:
> > The new 'wrapper' code generates files that git should ignore;
> > add them to .gitignore.
> 
> Why don't we just add these files to be cleaned correctly?

Its cleans up 'git status' in a tree that you've built.

Mark
