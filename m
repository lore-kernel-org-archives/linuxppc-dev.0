MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15985.4233.198025.809102@gargle.gargle.HOWL>
Date: Fri, 14 Mar 2003 00:13:13 +0100
From: mikpe@csd.uu.se
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mikpe@csd.uu.se, Olaf Hering <olh@suse.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.20-ben8 vmlinux.coff CLAIM error on PowerMac 4400
In-Reply-To: <1047576187.789.82.camel@zion.wanadoo.fr>
References: <15984.39762.858447.704784@gargle.gargle.HOWL>
	<20030313152506.GB28311@suse.de>
	<15984.43692.736225.647094@gargle.gargle.HOWL>
	<1047571502.790.76.camel@zion.wanadoo.fr>
	<15984.47873.428447.186049@gargle.gargle.HOWL>
	<1047576187.789.82.camel@zion.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:
 > On Thu, 2003-03-13 at 18:08, mikpe@csd.uu.se wrote:
 > > Benjamin Herrenschmidt writes:
 > >  > what are the respective sizes of the working 2.4.6 kernel
 > >  > and my non working 2.4.20 ? Can you try to shrink the 2.4.20
 > >  > down to the 2.4.6 size (removing drivers etc...) and see if
 > >  > that helps ?
 > >
 > > I doubt it's a size problem. My 2.4.20 vmlinux.coff was about 700K,
 > > since I only included the drivers and file systems I actually use.
 > > Olaf's 2.4.6 vmlinux.coff that booted fine is 1.3M.
 >
 > Ok, good to know. Right now I have no exact clue but I suggest
 > you try changing the .coff wrapper in arch/ppc/boot of 2.4.20
 > to what it was in 2.4.18 and tell me if that helps.

vmlinux.coff built from 2.4.18, both vanilla and with Olaf's patch in
http://penguinppc.org/~olaf/2.4.18/01_linux-2.4.18-rc4-lxppc_devel-0.diff.gz,
boots Ok. However, 2.4.18 has the "excessively slow swim3 floppy writes"
problem I mentioned earlier that 2.2.24 doesn't have.

I also tried 2.4.20-ben8 with coffmain.c from 2.4.18 as you suggested,
but it got the same CLAIM error as before. (hack-coff.c was unchanged
and I didn't find anything else coff-related.)

/Mikael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
