Date: Wed, 3 Mar 1999 21:32:11 +0000 (localtime)
From: Wayne Chang <wcx@iname.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Anyone know what this means?
Message-ID: <Pine.LNX.3.96.990303212842.348A-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was trying to compile a qt-based web browser (qweb) and got all the way
to the linking (I think) when I got this error:


Style.o: In function `QarrayT<char> type_info function':
/usr/lib/qt/include/qarray.h(.text+0x338): undefined reference to 
`StyleSheetProto::findDisplay(QString const &)'
collect: ld returned 1 exit status
make: *** [bin/qweb] Error 1


Is this because I am using the wrong version of Qt? I have the 1.42 RPMs
from ftp.linuxppc.org.

--
Wayne Chang
http://come.to/wcx

"Everything important has been said before."


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
