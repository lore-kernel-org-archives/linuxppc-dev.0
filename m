Date: Fri, 7 May 1999 21:36:00 -0500 (CDT)
From: Derek Moeller <moeller@networksplus.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: LinuxPPC/iMac instabilities
In-Reply-To: <199905072136.QAA18422@cegt201.bradley.edu>
Message-ID: <Pine.LNX.3.96.990507212523.1403B-100000@ns1.networksplus.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I've been having instabilities with the installation on the
iMac<RevA>. It has been persistent since the beginning of installation,
and can force me to do a reboot as much as once a day. Other that that, it
has been very stable.
	The particulars of the problem: When switching between VCs (ie
cmd-F1) it will sometimes, after the screen clear, print "FB: Overflow
xxx" where xxx is a number that increments rapidly with slowing speed as
time progresses. This isn't FBDev since it's on the console, not X. Has
anyone else experience this problem under the iMac? I use the boot
commands of video=atyfb:vmode:17,cmode:16 . I would like to know whether
I'm experiencing an isolated incident, whether a fix is forthcoming, or
whether it's already been fixed.
	Some more info: it overflows after a period of time. For example,
I left the machine on for awhile, and when coming back to it it took less
than 5 minutes for it to give me the Overflow stuff. Installation is R4.1
CD. I've tried to be good at giving as much info, if I've missed something
(probably have) ask. Oh, also - it _never_ happens unless I am actively
switching VCs.
	Thank you in advance!

--

+----------------------------------------+
| Derek Moeller moeller@networksplus.net |
|     Linux for PowerPC User, Student    |
|   http://www.networksplus.net/moeller	 |
|	*	   *		*	 |
|    "aut inveniam viam aut faciam"	 |
+----------------------------------------+

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
