Date: Thu, 29 Jul 2004 00:44:26 +0200
From: Colin Leroy <colin@colino.net>
To: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: adm103x module and 2.6.8
Message-ID: <20040729004426.033e48a3@jack.colino.net>
In-Reply-To: <20040728221825.34917851.cedric.pradalier@inrialpes.fr>
References: <20040728221825.34917851.cedric.pradalier@inrialpes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 28 Jul 2004 at 22h07, Cedric Pradalier wrote:

Hi,

> I've just seen that from kernel 2.6.8, lm-sensors modules will be
> supporting adm1030 and adm1031 thermal control chip.
>
> As it does not make sense to have two competing modules for the same
> piece of hardware, I strongly advise people to test and use these
> modules to control the the chip on their ibook2.2, rather than using my
> therm_adm103x module.

BenH said more than once that he preferred dedicated temperature and fan
drivers for mac hardware than generic lm_sensors.

The fact your driver still isn't included strikes me as a bit odd, given
that mine has been quite quickly. You had positive feedback about
therm_adm103x now, and maybe Ben forgot about it?
--
Colin
  http://www.colino.net/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
