From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Xavier Grave" <grave@ipno.in2p3.fr>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
Date: Tue, 22 Oct 2002 19:12:41 +0200
Message-Id: <20021022171241.1906@192.168.4.1>
In-Reply-To: <200210221503.RAA21965@ipnmail.in2p3.fr>
References: <200210221503.RAA21965@ipnmail.in2p3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Use "fbdev" as the driver in xfree, that will cause X to
>> run unaccelerated on top of radeonfb, so it will at least
>> be able to set mode & colors properly.
>>
>> I think support for the 9000 have been added to XFree CVS
>> recently, though that may not yet be in the DRI one (and
>> so Michel snapshots). The XFree CVS is beeing merged
>> again into the DRI one now, so this should be fixed soon.
>
>where can I find the .deb files from Michel, please ?

I don't have them at hand, ask him for instructions

Michel Dänzer <daenzer@debian.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
