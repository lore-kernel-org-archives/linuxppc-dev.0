Message-ID: <40487F63.6030703@246tNt.com>
Date: Fri, 05 Mar 2004 14:23:47 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Strange code in head.S
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

While looking at head.S, I noticed that in the FTR Section
CPU_FTR_HAS_HIGH_BATS, the register used during all the mtspr
SPRN_DBATxx,r20 is r20.
But shouldn't it be r10 ?
In the 2.4 version it was r20 but for all the preceding code of
clear_bat, it has been replaced with r10 but not in the FTR ...

Maybe I'm wrong, I'm not working on an arch that uses it. It's just
seems strange to me ...

Sylvain Munaut


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
