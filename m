Date: Wed, 1 Oct 2003 07:32:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@motorola.com>
Cc: Dan Malek <dan@embeddededge.com>,
	Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Message-ID: <20031001143243.GE12343@ip68-0-152-218.tc.ph.cox.net>
References: <3F79A106.8010608@embeddededge.com> <3F417AA6-F41B-11D7-B134-000393DBC2E8@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F417AA6-F41B-11D7-B134-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 01, 2003 at 09:26:29AM -0500, Kumar Gala wrote:

> Did I miss something or did is someone moving this patch from 8xx to
> 8260?  It looks like Tom's commit of Joakim's work was for 8xx.

No one has moved this to 8260 as no one with access to hw (not me,
easily) has time to do it.  If you can, I'll apply it.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
