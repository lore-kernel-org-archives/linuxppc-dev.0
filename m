Return-Path: <bwarren@qstreams.com>
Received: from web302.biz.mail.mud.yahoo.com (web302.biz.mail.mud.yahoo.com
	[68.142.199.178]) by ozlabs.org (Postfix) with SMTP id 29D0FDDD08
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 23:55:30 +1100 (EST)
Date: Tue, 13 Mar 2007 05:55:28 -0700 (PDT)
From: Ben Warren <bwarren@qstreams.com>
Subject: Re: Problem in compiling a kernel module
To: idefix@fechner.net
In-Reply-To: <20070313043050.GB82243@server.idefix.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <513703.69187.qm@web302.biz.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matthias,

--- Matthias Fechner <idefix@fechner.net> wrote:

> Hello Grant,
> 
> * Grant Likely <grant.likely@secretlab.ca> [12-03-07
> 12:36]:
> > Looks like you're trying to access inital data
> (which is freed after
> > module load) from regular code (which is not)
> 
> is it possible to find the line of code with the
> address is these
> warnings?

Is there any chance that you qualify private data as
__init within the driver?  Can you post the cleanup()
function and any private (static) functions that it
calls?

regards,
Ben
