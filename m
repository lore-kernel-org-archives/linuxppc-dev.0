Message-ID: <6B546A602AD2D211BFF00008C7A4288905844039@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'paulus@samba.org'" <paulus@samba.org>,
	"'mcharleb@qualcomm.com'" <mcharleb@qualcomm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: RE: Kernel Module; globals badly initialized, help needed.
Date: Thu, 28 Mar 2002 09:42:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul,
Hi Marc,

It looks like the issue is caused by insmod of Busybox...

I posted a question about it on the BusyBox mailing list.
Somebody mailed me that he has a similar problem that he solved by updating
his busybox but I did not see any reference to this issue in the BB
changelog.

Thanks,
Frederic

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
