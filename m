Message-ID: <379EF84B.8E9B69D4@zg.tel.hr>
Date: Wed, 28 Jul 1999 14:32:13 +0200
From: Stanko Juzbasic <stanko.juzbasic@zg.tel.hr>
Reply-To: stanko.juzbasic@zg.tel.hr
MIME-Version: 1.0
To: Bill Schottstaedt <bil@ccrma.Stanford.EDU>, paulus@cs.anu.edu.au,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Audio file open problem on LINUXPPC 1999 solution
Content-Type: text/plain; charset=iso-8859-1; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


To whoever it may concern

It seems I found the cause and solution to the LINUXPPC 1999 audio file
open problem I wrote about two days ago:

The problem occurs only if one installs the new LINUXPPC 1999 filesystem
from scratch using the release CD-ROM installer. It has several  bugs,
among which this one:

- it fails to create /dev/dsp (eventhough it creates /dev/dsp1...),
without giving a notice
- default system sound apps have an endianness problem, so they don’t
give a proper
    error message.

The solution is to [MAKEDEV audio] manually and rebuild CCRMA sndlib,
and sound will work perfectly.

Best,

Stanko
.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
