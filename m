Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC06082@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: How is eth0 config?
Date: Wed, 15 Jan 2003 08:41:40 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Could some one explain to me how CONFIG_IP_PNP is used to configure eth0 and
lo briefly? Ie what config files are used and when ? just basics would be
perfect (even a URL)...

I currently am having problems with my eth0 being configure in one image but
not the other (with the same kernel which has CONFIG_IP_PNP configured and a
good bootline (below)).

Thanks as always,
Jim

Ps

bootargs root=/dev/ram rw
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off
console=ttyS0;bootm 0x2900000 0x2A00000

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
