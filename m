MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16310.51046.819605.41542@cargo.ozlabs.ibm.com>
Date: Sun, 16 Nov 2003 11:40:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Cc: Alan Modra <amodra@bigpond.net.au>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel oops due to unaligned access with lswi
In-Reply-To: <20031115210449.GA10105@suse.de>
References: <20031115210449.GA10105@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Olaf,

> 	lswi 9,31,8
> 	stswi 9,28,8
>
> s = r31. How can gcc be sure that s aligned?

What machine is this?  I looked at the manuals for 750, 7450, POWER4
and they all handle unaligned string ops in hardware.  The alignment
handler doesn't handle string ops, I believe, although it could.  And
which arch (ppc32 or ppc64)?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
