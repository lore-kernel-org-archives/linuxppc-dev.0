Date: Mon, 29 Jan 2001 12:37:00 +0100 (MET)
From: Derek Homeier <supas100@astrophysik.uni-kiel.de>
To: linuxppc-dev@lists.linuxppc.org
cc: Brad Midgley <brad@turbolinux.com>
Subject: Re: pmud monitoring temperature (Re: powerbook doubles...)
In-Reply-To: <200101290601.AAA31864@lists.linuxppc.org>
Message-ID: <Pine.SOL.3.95.1010129121607.21410A-100000@juliet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 29 Jan 2001 01:49:14 -0000, Brad Midgley <brad@turbolinux.com> wrote:
>
> > until we have proper heat control in the kernel, maybe pmud should monitor the temperature and
> put
> > the machine to sleep if it runs too hot.
>
> i'm looking into this part.
>
> btw, what is a dangerous temperature? with the bays empty and a housefan running nearby (ie
> relatively cool) it is reporting 42c.
>
Actually, IBM and Motorola specs say the G3 has an operating temperature
of up to 105C!

http://e-www.motorola.com/brdata/PDFDB/MICROPROCESSORS/32_BIT/POWERPC/MPC7XX/MPC750EC.pdf

(Quite different from Intel's stuff, isn't it? ;^)
Before I read that, I used to worry myself when the heat-conducting plate
above the cpu was hot to the touch when opening the keyboard (which
probably means about 60C). As it is, you'll probably have to worry more
about the harddisk and other components.
Still, looking forward for a temperature monitor in pmud :-)

Thanks for your efforts,
								Derek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
