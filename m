Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 17A23DE08C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 10:32:46 +1000 (EST)
Date: Thu, 11 Oct 2007 19:38:10 -0500
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc: Implement logging of unhandled signals
Message-ID: <20071012003810.GA18472@lixom.net>
References: <20071001203242.GA14091@lixom.net>
	<20071002053512.GA21414@lixom.net>
	<20071012002007.GA18188@lixom.net>
	<1192148469.8476.64.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192148469.8476.64.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 12, 2007 at 10:21:09AM +1000, Benjamin Herrenschmidt wrote:
> 
> On Thu, 2007-10-11 at 19:20 -0500, Olof Johansson wrote:
> > Implement show_unhandled_signals sysctl + support to print when a process
> > is killed due to unhandled signals just as i386 and x86_64 does.
> > 
> > Default to having it off, unlike x86 that defaults on.
> 
> Why ? I'd like it on by default :-)

Paulus mentioned on IRC that he preferred it that way. I'll leave it up
to the two of you to argue it out. I'd prefer on by default but I don't
really care all that much as long as I can enable it with bootargs.


-Olof
