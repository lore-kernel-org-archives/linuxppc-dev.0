MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15985.64740.932276.359232@gargle.gargle.HOWL>
Date: Fri, 14 Mar 2003 17:01:40 +0100
From: mikpe@csd.uu.se
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mikpe@csd.uu.se, Olaf Hering <olh@suse.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.20-ben8 vmlinux.coff CLAIM error on PowerMac 4400
In-Reply-To: <1047648731.689.7.camel@zion.wanadoo.fr>
References: <15984.39762.858447.704784@gargle.gargle.HOWL>
	<20030313152506.GB28311@suse.de>
	<15984.43692.736225.647094@gargle.gargle.HOWL>
	<1047571502.790.76.camel@zion.wanadoo.fr>
	<15984.47873.428447.186049@gargle.gargle.HOWL>
	<1047576187.789.82.camel@zion.wanadoo.fr>
	<15985.4233.198025.809102@gargle.gargle.HOWL>
	<1047648731.689.7.camel@zion.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:
 >
 > > vmlinux.coff built from 2.4.18, both vanilla and with Olaf's patch in
 > > http://penguinppc.org/~olaf/2.4.18/01_linux-2.4.18-rc4-lxppc_devel-0.diff.gz,
 > > boots Ok. However, 2.4.18 has the "excessively slow swim3 floppy writes"
 > > problem I mentioned earlier that 2.2.24 doesn't have.
 > >
 > > I also tried 2.4.20-ben8 with coffmain.c from 2.4.18 as you suggested,
 > > but it got the same CLAIM error as before. (hack-coff.c was unchanged
 > > and I didn't find anything else coff-related.)
 >
 > Can you try -ben8 and change _both_ ALIGN(8) to ALIGN(4096) ?

In ld.script you mean? I noticed the second ALIGN(8) for bss and
changed it to 4096 yesterday: it doesn't fix the problem.

/Mikael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
