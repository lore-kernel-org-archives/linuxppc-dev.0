Subject: Re: 2.4.20-ben8 vmlinux.coff CLAIM error on PowerMac 4400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mikpe@csd.uu.se
Cc: Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15984.47873.428447.186049@gargle.gargle.HOWL>
References: <15984.39762.858447.704784@gargle.gargle.HOWL>
	 <20030313152506.GB28311@suse.de>
	 <15984.43692.736225.647094@gargle.gargle.HOWL>
	 <1047571502.790.76.camel@zion.wanadoo.fr>
	 <15984.47873.428447.186049@gargle.gargle.HOWL>
Content-Type: text/plain
Message-Id: <1047576187.789.82.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 13 Mar 2003 18:23:08 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-03-13 at 18:08, mikpe@csd.uu.se wrote:
> Benjamin Herrenschmidt writes:
>  > what are the respective sizes of the working 2.4.6 kernel
>  > and my non working 2.4.20 ? Can you try to shrink the 2.4.20
>  > down to the 2.4.6 size (removing drivers etc...) and see if
>  > that helps ?
>
> I doubt it's a size problem. My 2.4.20 vmlinux.coff was about 700K,
> since I only included the drivers and file systems I actually use.
> Olaf's 2.4.6 vmlinux.coff that booted fine is 1.3M.

Ok, good to know. Right now I have no exact clue but I suggest
you try changing the .coff wrapper in arch/ppc/boot of 2.4.20
to what it was in 2.4.18 and tell me if that helps.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
