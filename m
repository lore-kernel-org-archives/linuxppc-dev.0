Message-ID: <20040203140115.33983.qmail@web40401.mail.yahoo.com>
Date: Tue, 3 Feb 2004 06:01:15 -0800 (PST)
From: Todd <to_dd@yahoo.com>
Subject: Re: ppcboot boot-up question
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As Gerald suggested, I tried disconnecting the serial
cable, which allowed the board to boot.
Changing the minicom instructions in the following way
allowed the board to boot with the serial cable
connected:

ctl-a, z, o, "modem and dialing"
remove entries for items A - L
save as the default file.

I am looking into converting over to ckermit.
Thanks Wolfgang and Gerald for responding to my
question.

best regards,
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
