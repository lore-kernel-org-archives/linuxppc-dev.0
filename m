Subject: Re: [PATCH] Take two of the new serial uart driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40C42337.20209@intracom.gr>
References: <40BF3206.8030705@intracom.gr>
	 <1086426744.4588.121.camel@imladris.demon.co.uk>
	 <20040605192221.GT15195@smtp.west.cox.net>
	 <1086472929.4862.12.camel@localhost.localdomain>
	 <40C42337.20209@intracom.gr>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jun 2004 09:36:19 +0100
Message-Id: <1086597379.29255.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-06-07 at 11:11 +0300, Pantelis Antoniou wrote:
> David Woodhouse wrote:
> >VFS: Mounted root (nfs filesystem).
> >Freeing unused kernel memory: 100k iné
> >sh-2.05b#

> The following patch fixes the problem by properly waiting
> two character times on mode change.

It had to be applied with 'patch -l' due to whitespace noise.

Now I get this:

VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 100k init
                                       íbash-2.05b#


--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
