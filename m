From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown
Message-ID: <14239.5584.749636.587908@gargle.gargle.HOWL>
Date: Wed, 28 Jul 1999 10:38:08 -0400 (EDT)
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Audio file open problem on LINUXPPC 1999 solution
In-Reply-To: <379EF84B.8E9B69D4@zg.tel.hr>
References: <379EF84B.8E9B69D4@zg.tel.hr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> "Stanko" == Stanko Juzbasic <stanko.juzbasic@zg.tel.hr> writes:

 Stanko> To whoever it may concern

 Stanko> It seems I found the cause and solution to the LINUXPPC 1999 audio
 Stanko> file open problem I wrote about two days ago:

 Stanko> The problem occurs only if one installs the new LINUXPPC 1999
 Stanko> filesystem from scratch using the release CD-ROM installer. It has
 Stanko> several bugs, among which this one:

 Stanko> - it fails to create /dev/dsp (eventhough it creates /dev/dsp1...),
 Stanko> without giving a notice - default system sound apps have an
 Stanko> endianness problem, so they don’t give a proper error message.

This was a problem I ran into as well.  As an additional note, IIRC doing
something to /dev/sequencer caused /dev/dsp to disappear.  I'm not exactly
sure about the circumstances.  I have to go back and recreate the problem.
But there is definitely something like this going on on my machine.

 Stanko> The solution is to [MAKEDEV audio] manually and rebuild CCRMA sndlib,
 Stanko> and sound will work perfectly.

Can you comment on rebuilding sndlib?  What does that affect?

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
