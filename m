From: jpgarcia@execpc.com
Date: Wed, 26 May 1999 00:25:48 -0500
Message-Id: <199905260525.AAA06870@pop02.execpc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: endian patches to esound, audiofile, x11amp_beta for pbG3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


attached are a set of patches for audiofile, esound (in PPC DR1.0), and x11amp-0.9_beta1.1-1 to fix the endian problems in sound.  I am running kernel 2.2.9 on a pbG3 300.  If you try to play mp3s and only get static, these should fix that.  they can be added into the .spec file to build an RPM no problem.  If anyone hasn't had this problem, i don't know why mine it acting odd.

Some of the patches are brute force, so there are better solutions out there.  Mostly quick late nite fixes so i can play mp3s.  But they work for me, so enjoy.  Any feedback would be cool.

--

Joseph Garcia
Madison, WI
jpgarcia@execpc.com

begin 640 jp_xsound_patches.tar.gz
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
<Y?[8!@OM=Y:3X/G:?>.W\?\Q_@;2(E+D "@  //_
 
end



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
