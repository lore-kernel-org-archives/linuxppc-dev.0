Date: Wed, 31 Jan 2001 17:40:24 +0100
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao
	mode
From: Chris Boot <bootc@worldnet.fr>
To: LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B69DFE88.9197%bootc@worldnet.fr>
In-Reply-To: <20010130165710.B22219@allspice.cs.swarthmore.edu>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> It might be something PPC specific as well and have nothing to do with
>> Paul's drivers.
>
> This is why I asked in a previous email whether anyone had ever burned
> a disk in DAO mode successfully on a pmac or in fact on any powerpc
> machine, but I've received no responses.  Hmm, maybe I should try to
> conduct a quick survey of this on linuxppc-user and/or debian-powerpc.

Well, I can't write a dao disk on my Panasonic CW-7502.  cdrecord complains
that it can't send the cue sheet, but the SCSI bus doesn't die in any way, I
can still mount and use disks on it afterwards (I only have the built-in
CD-ROM and my CD-R on it).  I can provide exactly what cdrecord says and any
other info if you wish.

This is on a Performa 5400/180 with an early pull of the 2.4.0 kernel from
bk.  Everything seems to be working fine, except for this (which isn't too
important for me).

Good luck,

--
    .-.        Chris Boot
    /v\     bootc@worldnet.fr
   // \\
  /(   )\   L   I   N   U   X
   ^^-^^   >Phear the Penguin<


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
