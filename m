Message-ID: <E69FF45ADA3BD511A25900047623CC4F12AB2E@jupiter>
From: Neil Wilson <NWILSON@Airspan.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Sandpoint X3 + network
Date: Wed, 17 Oct 2001 15:15:57 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
My interim dev package is a Sandpoint X3 with an MPC7450 processor.  I can
build & get loaded the stock linuxppc_2_4_devel build, it boots, recognises
the RTL8139 network card and tries to communicate to a host for an nfs
mount.  I can see using portmap & tcpdump that the sandpoint sends out its
requests & I believe portmap is responding but nothing ever progresses on
the sandpoint beyond it giving up and trying to use default values for the
ports.  Eventually it starts giving "eth0: Too much work at interrupt,
IntrStats=0x0010" errors.

Whilst I am trying to look at this problem I was wondering if anyone else
has seen similar or even better knows why & has a cure.  I have the
sandpoint switches at the default position.  The same problem occurs if I
use other NICs ie. 3com,AMD etc.

Thanks.

Neil
--
-------------------------------------------------------
Neil Wilson                 Airspan Communications Ltd.
nwilson@airspan.com         Cambridge House
Tel: 01895-467265           Oxford Road

                            Uxbridge
                            Middlesex
www.airspan.com             UB8 1UN
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
