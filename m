Subject: Re: Console on SMC2 (was: Re: MPC823 Serial ports)
To: nmisch@erols.com (Noah Misch)
Date: Mon, 25 Oct 1999 13:20:45 +1000 (EST)
Cc: greyham@research.canon.com.au, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <v04011701b43979e6eac3@[216.164.132.49]> from "Noah Misch" at Oct 24, 99 11:08:44 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19991025032045.B64588498@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Noah Misch writes:
> They were replaced by /dev/ttyS*.

On our Linux 2.2 Intel boxes, opening /dev/ttyS* blocks until the modem
control lines become active if the port is in non-CLOCAL mode, whereas
/dev/cua* doesn't. Since you can't change mode without opening the device,
/dev/cua* is required to avoid the chicken-and-egg problem. Have the semantics
of /dev/ttyS* changed to remove the need for /dev/cua*?

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
