Date: Sun, 27 Jan 2002 16:27:37 -0800
From: Tim Moss <ppc@to11.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.18-pre7-ben0 MESH SCSI error
Message-ID: <20020128002737.GC10356@hmpiii2.trinity200.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just got around to upgrading the kernels on my 9500/180 and 9500/132
to 2.4.18-pre7-ben0 from benh 2.4.14-ben0. I use the exact same kernel
on both machines and 2.4.14-ben0 has been working fine. On the 9500/180,
2.4.18-pre7-ben0 works well so far but it won't boot on the 9500/132. It
loads the MESH driver and then just continues spitting out this message
until I turn the machine off

mesh: SCSI bus reset detected: waiting for end...done

Any idea how to get this working on the 9500/132?
Thanks

--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
