Date: Mon, 22 Oct 2001 21:48:19 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: Dave Ray <g4tinker@yahoo.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound on G4 tower, almost 
In-Reply-To: <20011023033817.16318.qmail@web13101.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0110222140340.20732-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 22 Oct 2001, Dave Ray wrote:

> The syslog messages that I posted previously do show
> some errors when loading dmasound_pmac. I'm wondering
> if those errors are related to the symptoms. Any help
> appreciated.

I looked at the output you posted, and I didn't see any errors in those
messages. I'm using the same driver (albeit on a FireWire iBook, which has
a DACA chip, but the messages are similar), and so I know there is nothing
in any of those messages to indicate any non-functioning (in fact, it
claimed to have found the Texas/Tumbler I2C mixer device). What program
are you using to try to change mixer settings? Have you tried playing any
audio, and if so, what happened? Did you receive an error, or did it just
play silently, or what?

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
