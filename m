Message-ID: <36DE4D9D.4699A6F6@wanadoo.fr>
Date: Thu, 04 Mar 1999 10:08:45 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: More problem in pre-R5
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I observed the following bug in the "more" program in pre-R5:
If I type "/" to do an expression search, then what I type after the "/"
is invisible, like when you type passwords. I can type blindly, and the
search works, but this is kind of annoying.

Does anyone else see this?

I might add that this problem does not appear if I use "less" instead of
"more". I tried several versions of util-linux, the latest being
util-linux-2.9h-9a. The problem stays the same. I haven't seen it in R4.

Any ideas?

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
