Date: Sat, 5 Jun 1999 11:27:14 -0600 (MDT)
From: Brad Midgley <brad@turbolinux.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Brad Midgley <brad@turbolinux.com>, linuxppc-dev@lists.linuxppc.org
Subject: control-c [Re: Mac-on-linux is now working...]
In-Reply-To: <19990603200523.030085@mail.mipsys.com>
Message-ID: <Pine.LNX.3.95.990605112445.6609A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


fyi, i found out that control-c doesn't stop mol if mol was started from
my shell script. so it may be something to do with signal handling...

perhaps when run from a script bash gets the control-c and sends the
interrupt signal to mol but mol was looking for a raw control-c? maybe
stty could change that behavior...

Brad
brad@pht.com | http://www.pht.com/~brad/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
