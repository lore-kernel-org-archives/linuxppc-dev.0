Message-ID: <A3E34B558F5CD211B4980008C7A4A99003C58340@GSO-SPARROW-SRV>
From: "Williams, Kevin M." <kevin.m.williams@marconi.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling and using hhl's glibc
Date: Tue, 31 Jul 2001 11:15:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I am getting ready, at long last, to start using glibc on our 603e based
>embedded board. Hitherto, I have not used and of the HHL tools. It does,
>however, look like their glibc has the best patches, so I'd like to give
>it a try.
....
>My first big question is whether or not all of the needed patched are
>already applied?

IMHO, if you want support for using HHL, you should purchase a MV
subscription.  Everything you get for free is already on their FTP site.

And no...I am not an MV employee.

>What modifications would need be made
>to the specs file to compile against this installed library.

I used --with-libs when I built gcc.

Kevin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
