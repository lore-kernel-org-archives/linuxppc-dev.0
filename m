Message-ID: <39AFD9E8.1BEF9ABC@embeddededge.com>
Date: Fri, 01 Sep 2000 12:31:36 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Gabriel Paubert <paubert@iram.es>,
        "Michel Ddnzer"
	<daenzerm@student.ethz.ch>,
        Tony Mantler <nicoya@apia.dhs.org>,
        Tom Rini
	<trini@kernel.crashing.org>, Dan Malek <dan@netx4.com>,
        linuxppc-dev
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
References: <Pine.LNX.4.10.10009011637420.373-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> Real men use `vi .config', delete some lines and type `make oldconfig' :-)

No, you actually further edit autoconf.h and just type 'make vmlinux'
(after removing the .o files not properly covered by dependencies :-).



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
