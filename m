Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
From: Gary Thomas <gary@mlbassoc.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kumar Gala <kumar.gala@motorola.com>,
	Dan Malek <dan@embeddededge.com>,
	Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20031001143243.GE12343@ip68-0-152-218.tc.ph.cox.net>
References: <3F79A106.8010608@embeddededge.com>
	 <3F417AA6-F41B-11D7-B134-000393DBC2E8@motorola.com>
	 <20031001143243.GE12343@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Message-Id: <1065019736.9737.526.camel@hermes>
Mime-Version: 1.0
Date: 01 Oct 2003 08:48:56 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-10-01 at 08:32, Tom Rini wrote:
> On Wed, Oct 01, 2003 at 09:26:29AM -0500, Kumar Gala wrote:
>
> > Did I miss something or did is someone moving this patch from 8xx to
> > 8260?  It looks like Tom's commit of Joakim's work was for 8xx.
>
> No one has moved this to 8260 as no one with access to hw (not me,
> easily) has time to do it.  If you can, I'll apply it.
>

I'll be glad to test this as well (sadly I don't have time today to
help with moving the patch).  I have access to both 8xx and 82xx boards.

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
