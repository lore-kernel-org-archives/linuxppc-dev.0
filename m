Message-ID: <17B78BDF120BD411B70100500422FC63079F4F@IIS000>
From: Patrick Lerda <Lerda@microprocess.com>
To: "'linux-kernel@vger.rutgers.edu'" <linux-kernel@vger.rutgers.edu>,
        "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: linux 2.3.99-pre5 OOPS on NFS code (PowerP C740) (Work with 2
	.3.99-pre3)
Date: Wed, 12 Apr 2000 11:59:31 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've tried  linux 2.3.99-pre5 on my PPC740 box, and it crashs
when the kernel mount the NFS partion to boot on. Linux 2.3.99-pre3
works well... the NIP indicate a crash in 'xdr_decode_fhstatus.'


Patrick LERDA


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
