Message-ID: <3C7FB6E7.3DB92F38@mvista.com>
Date: Fri, 01 Mar 2002 11:14:15 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Owen Green <owenjinggreen@yahoo.com>
Cc: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>,
	"'Christian Pellegrin '" <chri@infis.univ.trieste.it>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: gdbserver ppc8xx
References: <20020301170127.49909.qmail@web20107.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Owen Green wrote:
>
> Thank you all guys for the tips,
> gdbserver was not working because linbss_files.so.2
> was not present on my  system /lib.
> By the way, why this was not shown when I typed:
> readelf gdbserver -d ?
>
> Thanks in advance,

libnss* is dlopened by glibc.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
