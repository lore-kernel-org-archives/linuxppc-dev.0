Subject: Re: ibmstb4 fixes
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040115193619.GF983@stop.crashing.org>
References: <1074028643.1526.42.camel@shiva.eth.saftware.de>
	 <20040115193619.GF983@stop.crashing.org>
Content-Type: text/plain
Message-Id: <1074196707.1526.8.camel@shiva.eth.saftware.de>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 20:58:28 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-01-15 at 20:36, Tom Rini wrote:
> > - two typo fixes for i2c and the ocp definition
>
> Is the first one related to dgibsons latest changes?

Yes, the buggy #define was introduced in rev. 1.5. It results in a
compile error if IBM_IIC_IS_FAST is not overridden by the board's
header.

> > Now that linuxppc_2_4_devel seems to be rather dead, would you accept a
> > patch that adds the smc91111 network driver to linuxppc-2.4?
>
> I'd rather the smc91111 driver be sent to Jeff Garzik for review so he
> can push it into linux-2.4 and offer hints / help to get it into 2.6.

ok.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
