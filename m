To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ATI Rage 128 Mobility very slow with 2.6.6 Debian kernel
References: <hhekp5ilky.fsf@theorie.physik.uni-muenchen.de>
Reply-To: Jens Schmalzing <j.s@lmu.de>
From: Jens Schmalzing <j.s@lmu.de>
Date: 28 May 2004 00:18:59 +0200
In-Reply-To: <hhekp5ilky.fsf@theorie.physik.uni-muenchen.de>
Message-ID: <hhn03t1pkc.fsf@theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Jens Schmalzing writes:

> a user of my Debian kernel packages reported today that his Xserver
> was really slow when using the drm interface.  After a number of
> tries, I have been able to reproduce the problem - the XFree86.0.log
> seems to go in an endless loop logging the line
>
>  (EE) R128(0): Idle timed out, resetting engine...
>
> over and over again.  This does not occur with the module from the
> dri-trunk, btw.

Forget this message, right after I sent it I was able to solve the
problem by forcing the Xserver to access the card in PCI mode.

Regards, Jens.

--
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
