Message-ID: <20011023182151.64337.qmail@web13103.mail.yahoo.com>
Date: Tue, 23 Oct 2001 11:21:51 -0700 (PDT)
From: Dave Ray <g4tinker@yahoo.com>
Subject: Re: Sound on G4 tower, almost 
To: Derrik Pates <dpates@dsdk12.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.33.0110222140340.20732-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- Derrik Pates <dpates@dsdk12.net> wrote:
> On Mon, 22 Oct 2001, Dave Ray wrote:
>
> > The syslog messages that I posted previously do
> show
> > some errors when loading dmasound_pmac. I'm
> wondering
> > if those errors are related to the symptoms. Any
> help
> > appreciated.
>
> I looked at the output you posted, and I didn't see
> any errors in those
> messages. I'm using the same driver (albeit on a
> FireWire iBook, which has
> a DACA chip, but the messages are similar), and so I
> know there is nothing
> in any of those messages to indicate any
> non-functioning (in fact, it
> claimed to have found the Texas/Tumbler I2C mixer
> device). What program
> are you using to try to change mixer settings? Have
> you tried playing any
> audio, and if so, what happened? Did you receive an
> error, or did it just
> play silently, or what?

All sound apps just play silently without complaint,
but errors appear in the syslog.

Just to give some more background, I'm running the
latest audiofile libs and latest esound libs,
enlightenment 0.16.5, kernel 2.4.13-BenH. Under
previous hardware, audio (awacs) always worked, and I
generally ran esound.

However for this debugging I'm leaving esound off and
I should still be able to get terminal beeps and play
mp3's from gqmpeg. All audio programs happily run,
without complaint, but no sound comes out. When I try
to adjust volume I get the syslog errors. I'm stumped
and open to any suggestions.

The following lines in the syslog looked suspicious:

Oct 19 20:53:48 garuda kernel: tumbler:no device
.....
.....
Oct 19 20:53:48 garuda kernel: i2c-keywest: Ack Status
on addr expected but got: 0x09 on addr: 0x34
.....
(see original post for full syslog)

I suspect that the driver is failing to open the real
hardware and registering a dummy device.

-Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
