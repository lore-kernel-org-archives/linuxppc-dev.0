Date: Fri, 21 Sep 2001 21:49:13 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: <tahoward@ntrnet.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: gatos ati.2 with XClaim VR 128
In-Reply-To: <Pine.LNX.4.33.0109211151230.929-100000@ranger>
Message-ID: <Pine.LNX.4.33.0109212130360.7209-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 21 Sep 2001 tahoward@ntrnet.net wrote:

> I did a little poking in r128_video.c, and it seems the multimedia table
> is never being initialized.  According to the XFree86 sources, there is no
> video bios under ppc linux.  Once the R128InfoPtr makes it into
> R128ReadMM_TABLE, the VBIOS field is null, and an attempt to dereference
> it segfaults the server.  Josh Huber's patch allows the code to run, but
> now I have a motionless black/green screen, and no sound.
>
> If I just want to get this working and I'm right about this being the
> problem, I could just hardcode the relevant info.  But where would I get
> the right values for the multimedia table?
>
> The bigger question is where the data for MM_TABLE is actually being
> stored on the card, if not in the bios?  I believe initialization is
> handled by open firmware, but what about card specific data?  Is it
> somewhere else, or do vendors just have to make sure their drivers know
> everything they need to know about their cards?

I don't have a non x86 r128 card so i never managed to look at what is
available in the rom, its a good idea to take a look and see
if the needed data for MM_TABLE is there, probably in a different offset
than in the x86 side.
But as i said i never had the chance to look at the OF code so i have
no idea if you'll find anything usefull in it.

Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
