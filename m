From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <yellowdog-devel@lists.yellowdoglinux.com>,
	"Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SMP kernel configuration question?
Date: Sat, 16 Feb 2002 20:26:10 +0100
Message-Id: <20020216192611.18399@smtp.wanadoo.fr>
In-Reply-To: <20020216144452.TKAF7187.tomts21-srv.bellnexxia.net@there>
References: <20020216144452.TKAF7187.tomts21-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi,
>
>I have never configured a kernel for SMP before.
>
>I turned on the obvious CONFIG_SMP=y in the .config but was prompted if I
>would like to distribute interrupts (IRQs) across all CPUs.
>
>What is the recommended setting for:
>
>CONFIG_IRQ_ALL_CPUS
>
>Any guidance here would be greatly appreciated.

Leave it to N. ideally, you should enable it, but I have experienced
lockups when this feature is enabled, I haven't yet figured out what's
going on (could be related to the lockup some users are experiencing
with SMP + HIGHMEM on some dual 800, let me know if you see the same).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
