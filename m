Message-ID: <3EFC634F.5040604@tataelxsi.co.in>
Date: Fri, 27 Jun 2003 21:01:27 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: jumbled characters on serial port
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
We have developed MCC drivers for mpc8260. For debugging the driver we
have put several printk in the code. Since the data is not ascii all the
time, sometimes the screen gets fully jumbled characters. I understand
that printing some binary data causes this.
We are using minicom and busybox .60.5. If anybody knows how to get the
characters back, please advise.
We tried closing down the minicom window and restarting minicom. This
does not help. More over we are getting jumbled chars, not secondary
font. (if I were running bash, i would have run `reset`. But I never
faced this in i386)

Thanks and regards,
om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
