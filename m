Message-ID: <3C6C270D.3010505@embeddededge.com>
Date: Thu, 14 Feb 2002 16:07:25 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Langus Matevz RDHW_EXT <langus@iskratel.si>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: starting with Linux on EST SBC8260
References: <7E8519F1A7C0D211B0D200A0C93AA60F08447D0B@ntmail.iskratel.si>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Langus Matevz RDHW_EXT wrote:

> I would like to ask you, how much effort would it be required to get Linux
> running on EST SBC8260. Since this is a very widely used board, probably a
> lot of peope have already ported Linux on it.

I ported it a long time ago.  It's part of the kernel sources.  Don't
try to use the EST tools, though.  I don't know if they have a boot rom
for that board yet, but I suspect you can flash PPCBoot with the EST tools
and then throw them away.

>
> Is there a step-by-step guide what should be compiled/installed/done to get
> it running?

I don't know if the MontaVista Journeyman kits are around anymore, but it
was supported and documented in there.

You could also search the PPCboot (and these) archives for information.

The board was more popular a couple of years ago when it was one of the
first ones around.  Lots of other, easier to use boards are available now,
for less money.  My EST boards became non-functional long ago, and they are
on the scrap heap.

Good luck.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
