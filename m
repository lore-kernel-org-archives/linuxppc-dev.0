In-Reply-To: <406B4BC8.4040501@embeddededge.com>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331164423.GA417@gate.ebshome.net> <20040331100318.B17284@home.com> <9B139B02-834D-11D8-9FF0-000A95A07384@sands-edge.com> <20040331150741.D17284@home.com> <406B4BC8.4040501@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A34D7CCE-839D-11D8-928B-000393DBC2E8@motorola.com>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Matt Porter <mporter@kernel.crashing.org>,
	John Whitney <johnw@sands-edge.com>
From: Kumar Gala <kumar.gala@motorola.com>
Subject: Re: Proposed changes to io.h
Date: Wed, 31 Mar 2004 23:30:08 -0600
To: Dan Malek <dan@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Agreed, however I dont remember how nice the assembler is (-me500) with
regards to accepting 'classic' FP instructions.  So, I'm in agreement
with Matt in that I'd prefer a build time option here.

- kumar

On Mar 31, 2004, at 4:52 PM, Dan Malek wrote:

>
> Matt Porter wrote:
>
>
>> ..... If e500 wanted a version they
>> can use the SPE option to add some code.
>
> This isn't an issue (yet) for e500.  The only 64-bit external bus is
> for the DDR.  The only functions using the quad word are for MTD flash,
> and all flash is on the 32-bit local bus.
>
>
> 	-- Dan
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
