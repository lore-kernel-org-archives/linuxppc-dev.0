Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3F3A3E2C.8040609@devcom.cz>
Date: Wed, 13 Aug 2003 15:33:32 +0200
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Ethernets on SCC2 and SCC3 on mpc8xx
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

we want to use our custom board with MPC823e as
easy firewall in our applications. We have two 10Mbit ethernet
on board connected to SCC2 and SCC3 channels.
Is it support in kernel
for using both SCC channels configured as ethernet
(eth0, eth1 devices) simultaneously ? I use 2.4.3 kernel
and there is only possibility to use SCC2 or SCC3
as ethernet, not both at the same time.

                          Thanks in advance, HANYS


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
