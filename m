Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 06017B712A
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Nov 2010 14:42:04 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add jump label support
From: Steven Rostedt <rostedt@goodmis.org>
To: michael@ellerman.id.au
In-Reply-To: <1289273608.21111.194.camel@concordia>
References: <45fbc3cd7f6ce404d1e25bf01695fb629d86189d.1289189560.git.michael@ellerman.id.au>
	<20101109133517.b6be28bf.sfr@canb.auug.org.au>
	<1289273608.21111.194.camel@concordia>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Mon, 08 Nov 2010 22:41:59 -0500
Message-ID: <1289274119.12418.79.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Kumar Gala <kumar.gala@freescale.com>, jbaron@redhat.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Anton Blanchard <anton@samba.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-11-09 at 14:33 +1100, Michael Ellerman wrote:

> > You don't need this protection in a file that is not exported to user
> > space.
> 
> Ah true. I'll respin after I've heard if anyone has tested it :)

Don't wait for me. I'm stuck debugging some other crap. Getting a 4.5
PPC compiler working is very low on my priority list, unfortunately. :-(

-- Steve
