Subject: Re: OF properties access ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040115074439.GB14039@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston>
	 <20040115074439.GB14039@iliana>
Content-Type: text/plain
Message-Id: <1074310140.8360.27.camel@gaston>
Mime-Version: 1.0
Date: Sat, 17 Jan 2004 14:48:11 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> But this doesn't reply me on why my attempts to read back integer values
> from OF property only result in the machine hanging, and since it is
> really early on, i don't even get serial console output to have an idea
> why :/
>
> in particular i cloned the code reading l2cr-value, and changed it to
> l2cr and instead of reading the value, i got only kernel silently dying.

Show me the code and the relevant device-tree bits.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
