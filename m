Message-ID: <B25E2E5A003CD311B61E00902778AF2A0204464B@SERVER1>
From: Brian Kuschak <brian.kuschak@skystream.com>
To: "'Dan Malek'" <dan@mvista.com>, Gabriel Paubert <paubert@iram.es>
Cc: Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: dcache BUG()
Date: Tue, 8 May 2001 08:43:14 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, it ran for about 4 1/2 hours, much longer than before Gabriel's patch,
but eventually failed the same way.

Brian

sh-2.03# while /bin/true ; do cat /proc/net/* 2>/dev/null > /tmp/junk; done
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
de_put: entry net already free!
dentry.d_count = 0
dentry.d_reftime = 134236224 (current = 1634369)
dentry.d_inode = c12badc0
dentry.d_name = net
kernel BUG at /home/brian/linux/include/linux/dcache.h:251!


-----Original Message-----
From: Dan Malek [mailto:dan@mvista.com]
Sent: Monday, May 07, 2001 6:44 PM
To: Gabriel Paubert
Cc: Eli Chen; Brian Kuschak; linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()


Gabriel Paubert wrote:

> I'm myself more and more convinced myself that this is really a bug,

I'm convinced, too, so thanks for the suggestion.  I think it is
much more likely to show up on the 4xx because of my (assumed)
implementation than on other processors that attempt to make some
use of the EA in the instructions.

> .... It does not fix Eli's problems, so
> either my patch is wrong or something else is going on.

We have many people testing on a variety of systems, so we will
know more shortly.

Thanks again.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
