Date: Thu, 15 Jan 2004 13:42:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Oberritter <obi@saftware.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ibmstb4 fixes
Message-ID: <20040115204215.GG983@stop.crashing.org>
References: <1074028643.1526.42.camel@shiva.eth.saftware.de> <20040115193619.GF983@stop.crashing.org> <1074196707.1526.8.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1074196707.1526.8.camel@shiva.eth.saftware.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 15, 2004 at 08:58:28PM +0100, Andreas Oberritter wrote:
> On Thu, 2004-01-15 at 20:36, Tom Rini wrote:
> > > - two typo fixes for i2c and the ocp definition
> >
> > Is the first one related to dgibsons latest changes?
>
> Yes, the buggy #define was introduced in rev. 1.5. It results in a
> compile error if IBM_IIC_IS_FAST is not overridden by the board's
> header.

OK.  There's some questions over those changes, so I'll hold off on that
half for now.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
