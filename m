Date: Fri, 14 Mar 2003 00:18:53 +0100
From: Olaf Hering <olh@suse.de>
To: mikpe@csd.uu.se
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.20-ben8 vmlinux.coff CLAIM error on PowerMac 4400
Message-ID: <20030314001853.A2524@suse.de>
References: <15984.39762.858447.704784@gargle.gargle.HOWL> <20030313152506.GB28311@suse.de> <15984.43692.736225.647094@gargle.gargle.HOWL> <1047571502.790.76.camel@zion.wanadoo.fr> <15984.47873.428447.186049@gargle.gargle.HOWL> <1047576187.789.82.camel@zion.wanadoo.fr> <15985.4233.198025.809102@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15985.4233.198025.809102@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Fri, Mar 14, mikpe@csd.uu.se wrote:

> I also tried 2.4.20-ben8 with coffmain.c from 2.4.18 as you suggested,
> but it got the same CLAIM error as before. (hack-coff.c was unchanged
> and I didn't find anything else coff-related.)

Your 4400 will work fine with kernel.org kernels.
I remember Eddie said it broke around 2.4.19-pre7 (probably the benh
version).
I do not have much oldworlds left, a 6400 has OF 2.0, I will try it
tomorrow.


Gruss Olaf

--
A: No.
Q: Should I include quotations after my reply?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
