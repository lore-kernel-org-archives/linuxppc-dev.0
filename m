Subject: Re: 2.4.20-ben8 vmlinux.coff CLAIM error on PowerMac 4400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mikpe@csd.uu.se
Cc: Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <15984.43692.736225.647094@gargle.gargle.HOWL>
References: <15984.39762.858447.704784@gargle.gargle.HOWL>
	 <20030313152506.GB28311@suse.de>
	 <15984.43692.736225.647094@gargle.gargle.HOWL>
Content-Type: text/plain
Message-Id: <1047571502.790.76.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 13 Mar 2003 17:05:02 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


what are the respective sizes of the working 2.4.6 kernel
and my non working 2.4.20 ? Can you try to shrink the 2.4.20
down to the 2.4.6 size (removing drivers etc...) and see if
that helps ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
