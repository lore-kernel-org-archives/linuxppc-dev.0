Subject: Re: [RFC] "indirect" DCR access (40x, BookE)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@motorola.com>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	linuxppc-embedded@lists.linuxppc.org,
	Stephen Williams <612dlag102@sneakemail.com>
In-Reply-To: <1921A482-7431-11D8-AFB6-000393DBC2E8@motorola.com>
References: <20040312014800.GA25455@gate.ebshome.net>
	 <405124A3.3040002@embeddededge.com>
	 <20040312030502.GA25644@gate.ebshome.net> <24019-11838@sneakemail.com>
	 <20040312045451.GA25876@gate.ebshome.net>
	 <1921A482-7431-11D8-AFB6-000393DBC2E8@motorola.com>
Content-Type: text/plain
Message-Id: <1079668852.909.88.camel@gaston>
Mime-Version: 1.0
Date: Fri, 19 Mar 2004 15:00:53 +1100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 2004-03-13 at 01:25, Kumar Gala wrote:
> Look in u-boot.  They have some user commands that allow
> reading/writing dcr's.  These commands are written with self modifying
> code, I would recommend that we reuse that.
>
> Also, it begs the question of should this be extended to SPRs, not that
> I have come across a case with SPRs that I need to iterate over a large
> list.

That would way too slow for DCRs used in drivers for example,

I much prefer Eugene's idea.

Ben.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
