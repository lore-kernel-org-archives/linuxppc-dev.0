In-Reply-To: <19990106170222.030778>
Date: Wed, 6 Jan 1999 18:21:16 +0100
To: tas@mindspring.com, linuxppc-dev@lists.linuxppc.org,
        Paul.Mackerras@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Great IDE perf (WAS: Strange PMAC IDE performance)
Message-Id: <19990106182116.029161@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I tested on the iMac, and we have also the same register with the same
value. All three machines have the compatible property of the ide in the
device tree set to "heathrow-ata". I'm building a test kernel along with
other patches I made with a quick hack for this, I'll post it soon with
diffs so people can play with it and do real testings.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
