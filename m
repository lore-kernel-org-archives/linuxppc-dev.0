Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Date: Mon, 7 Dec 1998 13:22:30 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: Cort Dougan <cort@ladron.cs.nmt.edu>,
        Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: L2CR patch
Message-Id: <19981207132230.001760@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Enclosed is a patch that replace the _set_L2CR function in the kernel by
a new version that is safer (does the appropriate flushing etc... when
enabling the cache).
See comments about usage. I also added an "l2cr=" kernel command-line
option that will be used by future versions of BootX to give the kernel a
correct l2cr setting for people with G3 upgrade cards. BootX application
will be able to "capture" the l2cr value set by the upgrade card software
and put it in a pref for use when booting.

The _set_L2CR was provided by Terry Greeniaus from PowerLogix, so thanks
to PowerLogix for the support !


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


--==_Boundary-1_==
Mime-Version: 1.0
Content-Type: application/octet-stream; name="l2cr.patches.tgz"; x-mac-creator="477a6970"; x-mac-type="477a6970"
Message-Id: <19981207132239.014501>
Date: Mon, 7 Dec 1998 13:22:39 +0100
Content-Transfer-Encoding: base64

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

--==_Boundary-1_==--



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
