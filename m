Message-ID: <38C21CBF.5A718EAE@ncal.verio.com>
Date: Sun, 05 Mar 2000 00:37:19 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: More Powerbook 2000 (Pismo) data
References: <38C208F3.FD613B63@ncal.verio.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




While finishing up the last message I decided to try booting again
as I had the eth0 activated under OS/9 and hadn't previously. Well this
time it appears the PHY registers were accessible. An extract from
the kmsgs is below:

<4>PHY regs:
<4>1000 782d 0040 6212
<4>01e1 0081 0000 0000
<4>0000 0000 0000 0000
<4>0000 0000 0000 0000
<4>1000 0301 0000 0000
<4>0000 0131 0100 0000
<4>003a d00e 0000 ff00
<4>002a 0000 0080 000b
<4>mii_interrupt, phy_status: 800e

Does this look more like what's expected?

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
