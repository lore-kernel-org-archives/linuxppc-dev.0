Message-ID: <38341E81.1B5730E0@netx4.com>
Date: Thu, 18 Nov 1999 10:42:57 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Orjan Gustavsson" <orjan@switchcore.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling for the FADS, yet again...
References: <45AFD48D077ED211BB4700A0C9DCE8FD012EDC@monza.broadswitch.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Örjan Gustavsson wrote:


> Which version of the kernel should I get?

Use the 2.2.13 tar image from ppc.kernel.org.  I do not (yet)
have 2.2.x updated with 8xx changes.  The 2.3.xx kernel has
almost everything.  When I am finished with the 82xx, I will
make another update there, as it affects some of the 8xx code.


> (I have tried to change .config directly, but it does not helped much)

You have to make corresponding changes in include/linux/autoconf.h.


> Will there be better support for the FADS, or is it a doomed project?


I have received a few FADS patches that I will get into CVS with
my next update, maybe over the holidays.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
