From: benh@kernel.crashing.org
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>,
	<yellowdog-devel@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: some questions on new dual 1Gig G4's support?
Date: Tue, 5 Feb 2002 14:23:11 +0100
Message-Id: <20020205132311.25477@mailhost.mipsys.com>
In-Reply-To: <20020204182315.PZGJ18463.tomts7-srv.bellnexxia.net@there>
References: <20020204182315.PZGJ18463.tomts7-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>But what about the SLEEP mode my last e-mail mentioned.  It is a different
>mode from NAP (does no bus snooping) but saves more power.

sleep already existed in previous CPUs, we almost don't use it. Actually,
we do use it on some laptops, but that's nothing you should have to care
about.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
