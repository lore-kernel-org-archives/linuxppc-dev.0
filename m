Message-ID: <36891198.A0420225@schweiz.ch>
Date: Tue, 29 Dec 1998 18:30:00 +0100
From: Andreas <a.tobler@schweiz.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: imake & pre-5
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

before X-mas I did a download of the pre-5 without the hdlist file. It was not
available until 21.12.98 as I saw this morning. Anyway, I brought it to
install and to work without online help (no connection available).
After the install I tried to recompile the sources I had from a previous download.
A simple make of a package abc worked, but when I tried to rpm -bc xyz I got a
segmentation fault made by imake. (and a core dump). Up to now I wasn't able
to localize where imake.c is in.  
Can anybody give me a hint where I can find it? I then may be able to find out
where the problem is.

Thanks for any hint

Andreas

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
