Message-ID: <3D1203B2.6050409@embeddededge.com>
Date: Thu, 20 Jun 2002 12:32:50 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <3D106922.7026437A@imc-berlin.de> <20020619150520.GA12762@opus.bloom.county> <3D10A0AC.409EF92B@imc-berlin.de> <20020619152528.GB12762@opus.bloom.county> <3D10F388.5@embeddededge.com> <20020619212246.GA16052@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> And in the (un)fortunate grand linux tradition, new features with some
> demand from the users behind them get backported too.  For example,
> 2.2.current (21? 22?) has all sorts of compat glue for 2.4 drivers and a
> rather current USB stack and all sorts of things like that..

It was probably done in 2.3.xx and backported, but yes, that does happen
and it is a good thing.  However, it was first done in the newer, development
tree before it was ported into the current, stable kernel.  I think
the first half dozen 2.4 releases were really 2.3.xxx, anyway :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
