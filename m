In-Reply-To: <OFE905D2F1.566CE02A-ON85256E99.0046D4AF-85256E99.00478089@LocalDomain>
Subject: Re: getting linux console on a frame buffer.
To: David Ho <DavidHo@nanometrics.ca>
Cc: geert@sonycom.com, Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Message-ID: <OFB18B1B47.575DB256-ON85256E99.00488B08-85256E99.0048EE6F@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Wed, 19 May 2004 09:16:36 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I tried your suggestion, but I noticed tty's are not initialized in
> my kernel startup log.  I'll looking into how I can start it.
> Otherwise, I lost the console (it does not appear on either tty0(fb)
> or ttyS0 (serial).

Okay Geert, Virtual terminal support is enabled in the kernel.
but when I tried echo hello > /dev/tty0, it is not connected to a device
driver?
Do you know what else is missing?

David

# echo hello > /dev/tty0
/dev/tty0: cannot create (No such device)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
