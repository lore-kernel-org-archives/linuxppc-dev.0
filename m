Content-Type: text/plain;
  charset="iso-8859-1"
From: Rick Cook <rcook@ntlug.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 9.1 Gbyte SCSI Drive
Date: Mon, 30 Apr 2001 21:17:39 -0500
MIME-Version: 1.0
Message-Id: <01043021173900.00603@p7300>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

Thanks for all of the suggestions. I'm not sure which one actually fixed
things, however, my 9.1 Gbyte drive is now happily running inside my 7300/200.

A couple of things different about this successful attempt to get it working.
It is SCSI ID 2, it is not the drive providing bus termination, it is running
in an already installed and running Debian environment, and the system is
running a 2.2.19 kernel.


Thanks again,

Rick
--
rcook@ntlug.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
