Message-ID: <0B0A39652BB0D411BCCF00508B9512EC106D80BE@tx14exm05.ftw.mot.com>
From: Guo Eileen-QEG000 <QEG000@motorola.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: ethtool on gianfar ethernet driver on MPC85xx platform
Date: Wed, 14 Jul 2004 09:15:19 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All,

I am using the gianfar ethernet driver on MPC8540 platform.
The gianfar driver itself includes code that supports ethtool
(gianfar_ethtool.c)
We downloaded the ethtool.c utility program version 1.8 and tried to access
the ethtool on gianfar driver.  Here is what we received when
entering the ethtool commands:
>ethtool -i eth0
Cannot get driver information:  Operation not supported
>ethtool -d eth0
Cannot get driver information:  Operation not supported

Does anyone know how to access the ethtool on the gianfar driver?

thanks,


Eileen Guo

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
