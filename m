Message-ID: <20020301170127.49909.qmail@web20107.mail.yahoo.com>
Date: Fri, 1 Mar 2002 09:01:27 -0800 (PST)
From: Owen Green <owenjinggreen@yahoo.com>
Subject: RE: gdbserver ppc8xx
To: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>,
	"'Christian Pellegrin '" <chri@infis.univ.trieste.it>
Cc: "'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <6B546A602AD2D211BFF00008C7A4288905844007@hrtades2.atea.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you all guys for the tips,
gdbserver was not working because linbss_files.so.2
was not present on my  system /lib.
By the way, why this was not shown when I typed:
readelf gdbserver -d ?

Thanks in advance,

Owen.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
