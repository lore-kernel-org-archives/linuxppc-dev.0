From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14245.48740.399981.423193@gargle.gargle.HOWL>
Date: Mon, 2 Aug 1999 11:51:00 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: Help with cd writing scsi error?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all.  I'm trying to burn an audio CD on a stock kernel.org 2.2.10 kernel on
a Powercenter (R5 dist).  The generic SCSI driver is built as a module.  I'm
using cdrecord-1.8a24, the latest I could find (1.8a21 gives the same error).
I'm setting shmmax to 16M.  My burner is a Panasonic CW-7502 with rev 4.17
firmware.

Basic info gathering from the drive seems to work fine.  I can extract digital 
audio as well.  I pulled one track off a disc to use as a writing test.  To do 
the test I try the following with a CDR blank in the drive:

cdrecord dev=3,0 -dummy -audio track.wav

I get the following error -

cdrecord Input/output error.  read track info: scsi sendcmd: retryable error
CDB: 52 01 00 00 00 FF 00 00 1C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 0A 00 00 00 00 64 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x64 Qual 0x00 (illegal mode for this track) Fru 0x0
Sense flags: Blk 0 (not valid)
cmd finished after 0.003s timeout 240s

cdrecord says it is using generic SCSI-3/mmc cdr driver (mmc_cdr) and driver
flags are SWABAUDIO.

Any ideas?

Thanks,
Jerry

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
