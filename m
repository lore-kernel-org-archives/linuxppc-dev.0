Subject: Re: RE : MPC5200Lite and PCI card IRQ
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bertrand Baudet <bbaudet@lacie.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1086381673.13911.17.camel@gaston>
References: <5A96167EBCEA8440A48790B5419953AE13C43D@gr-lafayette.lacie.com>
	 <1086381673.13911.17.camel@gaston>
Content-Type: text/plain
Message-Id: <1086381847.13914.19.camel@gaston>
Mime-Version: 1.0
Date: Fri, 04 Jun 2004 15:44:08 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> This is a none bug of some old drivers. 0 should be replaced by the
            ^^^^
   can't type today ... "known" of course

> arch-defined NO_IRQ constant, which on ppc can conveniently by set
> to -1. In the meantime, just hack around :)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
