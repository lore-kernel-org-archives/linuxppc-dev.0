Message-Id: <5.1.0.14.2.20011112114211.00bd4350@falcon.si.com>
Date: Mon, 12 Nov 2001 11:49:37 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Flash programing
In-Reply-To: <5BFFEE450E4C9264CB2CB0E906D67860@j_padron.joseane.zzn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 10:09 AM 11/12/01 +0100, Juan Padron wrote:

>Hi:
>
>  I´m new in this list.
>  I have a beginner question.
>  We have Metrowerks CodeWarrior (for Windows). It has a little
> application and we use it to program the flash (via the Wigglers BDM):
> write and erase.
>But now, we are starting with embedded linux and we want to know how we
>can program the flash fron Linux using the BDM.

Wolfgang covered most aspects of this.  If, however, your question is how
to use the Wiggler BDM from a linux workstation instead of a WinXX
workstation, the answer is that it isn't readily possible.  There are no
linux Wiggler drivers.

Note that this isn't just an issue of how to wiggle the wiggler pins.  You
also have to know how to address the internals of the PPC CPU, which is a
Motorola trade secret.  You have to sign agreements with them before they
will tell you how to use the JTAG port to access the internal registers.

>   Could you help me?

Sorry, probably not :-/

>   Thank you for your help.
>
>Obtenga su E-mail GRATUITO en http://joseane.zzn.com

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
