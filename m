Message-Id: <v04003a0ab6a5a95349d9@[24.70.162.12]>
In-Reply-To: <20010206073853.6DE76DBA0E@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Feb 2001 07:20:00 -0600
To: "Iain Sandoe" <iain@sandoe.co.uk>, Takashi Oe <toe@unlserve.unl.edu>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: SOLVED: mesh SCSI bus locks hard on 7500 when burning a CD-R
  in
Cc: bob@kunk.jriver.com, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:38 AM -0600 2/6/2001, Iain Sandoe wrote:
>> 7100.  G3 desktop comes with mesh.
>
>I have 9600 with both MESH & 53C94 - both have devices - and my CD-RW is on
>that machine (not tried under linux yet).
>
>So, time willing, I'm happy to test things.

Ditto. The latest BK-Rsync seems to be working on my 9600/200mp, so I'll be
able to test new scsi drivers too.

On the plus side, my root volume is on a Promise IDE card, so no danger in
messing that up. :)

I've got a CDRom on the MESH side and a zip drive on the 53c94 side, plus a
DDS-1 tape drive that I can put on either. Should be disconnects-o-plenty
there.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
