MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15984.47873.428447.186049@gargle.gargle.HOWL>
Date: Thu, 13 Mar 2003 18:08:17 +0100
From: mikpe@csd.uu.se
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mikpe@csd.uu.se, Olaf Hering <olh@suse.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.20-ben8 vmlinux.coff CLAIM error on PowerMac 4400
In-Reply-To: <1047571502.790.76.camel@zion.wanadoo.fr>
References: <15984.39762.858447.704784@gargle.gargle.HOWL>
	<20030313152506.GB28311@suse.de>
	<15984.43692.736225.647094@gargle.gargle.HOWL>
	<1047571502.790.76.camel@zion.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt writes:
 > what are the respective sizes of the working 2.4.6 kernel
 > and my non working 2.4.20 ? Can you try to shrink the 2.4.20
 > down to the 2.4.6 size (removing drivers etc...) and see if
 > that helps ?

I doubt it's a size problem. My 2.4.20 vmlinux.coff was about 700K,
since I only included the drivers and file systems I actually use.
Olaf's 2.4.6 vmlinux.coff that booted fine is 1.3M.

/Mikael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
