In-Reply-To: <20040803080047.GC27809@iram.es>
References: <40F57D15.8030700@pi.be> <69A5B0EA-D669-11D8-A9B5-000393DBC2E8@freescale.com> <40F8138F.8090004@pi.be> <20040803080047.GC27809@iram.es>
Mime-Version: 1.0 (Apple Message framework v618)
Message-Id: <98EA954A-E60A-11D8-A013-000A95A4DC02@kernel.crashing.org>
Cc: Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-dev@lists.linuxppc.org, Stef Simoens <stef.simoens@pi.be>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] align.c
Date: Wed, 4 Aug 2004 13:36:59 +0200
To: Gabriel Paubert <paubert@iram.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> While I was at it, Paulus asked me to handle stmw/lmw and stswx/lswx
>> as
>> well...
>
> Personnaly I disagree for stmw/lmw, they are specified to
> work only for word-aligned addresses.

That's what the PEM says, but the architecture Books disagree.  Don't
trust the PEM :-)

Also, in some implementations, lmw/stmw can fail for any number of
reasons (e.g., using them while in wrong-endian mode, etc.) so it's
nice to be able to emulate them.


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
