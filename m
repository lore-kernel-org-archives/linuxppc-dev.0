Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC06083@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: James Don <JDon@spacebridge.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: How is eth0 config?
Date: Wed, 15 Jan 2003 08:44:24 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Cancel the question my bootline was truncated ... Kernel command line:
root=/dev/ram rw

-----Original Message-----
From: James Don
Sent: Wednesday, January 15, 2003 8:42 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: How is eth0 config?

Could some one explain to me how CONFIG_IP_PNP is used to configure eth0 and
lo briefly? Ie what config files are used and when ? just basics would be
perfect (even a URL)...

I currently am having problems with my eth0 being configure in one image but
not the other (with the same kernel which has CONFIG_IP_PNP configured and a
good bootline (below)).

bootargs root=/dev/ram rw
ip=$(ipaddr):$(serverip):$(gatewayip):$(netmask):$(hostname)::off
console=ttyS0;bootm 0x2900000 0x2A00000

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
