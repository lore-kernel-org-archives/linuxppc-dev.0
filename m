Date: 13 Nov 2001 04:07:07 -0000
Message-ID: <20011113040707.18867.qmail@mailweb26.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: IDE in Mode 1 (Sandpoint) how ?
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
> Sounds like you have the switches in the wrong position
> and the interrupts
> are not routed correctly.  The serial port will
> eventually time out when it
> doesn't receive interrupts, giving the perception of a
> very slow running system.
>
> Just keep in mind the troubles are local to your
> configuration, as this software
> operates fine on a properly configured board.  Just
> move switches until it works,
> then leave them alone :-).

  Ur suggestion is acceptable. But whatss troubling
my head is, the kernel boots up fine until the NFS mount.
Had the switch settings been wrong, the serial output
would be slow from early bootup, right ?  But thats
not the case. Why should it be slow after INIT starts
up ?
 Meanwhile, I am also trying the same with different
switch settings.

Thanks
Sarnath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
