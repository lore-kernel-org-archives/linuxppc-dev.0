In-Reply-To: <1074906498.1262.52.camel@gaston>
References: <20040123111725.GB23537@iliana> <1074883450.2842.9.camel@otta.rchland.ibm.com> <20040123185433.GB5125@iliana> <1074906498.1262.52.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v609)
Message-Id: <62A0C520-4FD4-11D8-99B7-000A95A4DC02@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Peter Bergner <bergner@vnet.ibm.com>,
	Sven Luther <sven.luther@wanadoo.fr>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: chrp mmu and booting.
Date: Mon, 26 Jan 2004 08:51:01 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> If you are talking about non-IBM HW, then you can't rely on what
> happens
> on IBM CHRP as a reference :) Any OF implementation does things
> differently
> (and for example, Apple's one runs in virtual mode, not in real mode,
> thus
> the translate call is useful in case you are loaded at a non-1:1
> address).

Any compliant PowerPC OF implementation is required to be able to run in
both real- and virtual mode.  Apple's OF runs in virtual mode by
default;
IBM's in real mode.  And neither runs very well in the "other" mode, as
it
is seldom (if ever) tested...


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
