Subject: Re: OF properties access ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040113114625.GA9294@iliana>
References: <20040113114625.GA9294@iliana>
Content-Type: text/plain
Message-Id: <1074131387.818.43.camel@gaston>
Mime-Version: 1.0
Date: Thu, 15 Jan 2004 12:49:47 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> But, the pmac OF (at least on the powerbook i got someone to check for
> me), does have a l2cr property, not a l2cr-value one. The same goes on
> for voltaire.debian.org, which is a dual G4 500MHz.
>
> Does this mean that the -value appended is for looking at the content of
> l2cr, or something such ?

No. The L2 is assumed to be set by the firmware. That "l2cr-value" is just
an optional thing that BootX can set before booting the kernel to force
a different L2 setup, typically used with G3 upgrade cards.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
