Date: Mon, 4 Oct 1999 08:27:13 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Elliot Lee <sopwith@redhat.com>
cc: Tom Rini <trini@kernel.crashing.org>, Eric Dorland <dorland@lords.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
In-Reply-To: <Pine.LNX.4.10.9910031740170.29018-100000@lacrosse.corp.redhat.com>
Message-ID: <Pine.GSO.4.10.9910040826360.15704-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 3 Oct 1999, Elliot Lee wrote:
> On Sun, 3 Oct 1999, Tom Rini wrote:
> > > It appears you're right. All the sounds that have trouble playing are 16bit
> > > 44kHz wavs. The weird thing is that if I start esd and use esdplay, all the
> > > sounds play properly. However the 16bit sounds don't appear to be going
> > > through esd because I don't get my prompt back until the sound is done
> > > playing, while the 8bit sounds are played asynchronously.
> 
> This may just be because the 16bit sound files are bigger...
> 
> > What happens is either audiofile or esound is doing byte swapping it
> > doesn't need to.
> 
> I think I heard somewhere that the PPC /dev/dsp uses little endian format,
> while Sparc uses its native (big) endianness.
> 
> If someone could give me a table of what endianness the sound devices on
> various platforms expect, I could make an esound-0.2.15 that fixes it
> (after having you all test it :).

There are different sound format codes for little and big endian 16 bit sound.
Look at the sound headers.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
