Message-ID: <3694BCE8.8997ADCD@jeol.com>
Date: Thu, 07 Jan 1999 08:55:52 -0500
From: John Malcolmson <jam@jeol.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Question about threads in Linuxppc 5.X
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am curious about the maximum number of native threads available per
process on linuxppc 5.X.  Specifically, I would like to confirm that
linuxppc can allow for at least 512 threads per user process.  This is
important to an application that we are considering porting to this
platform.  Currently, our closest target is AIX 4.3.2.

Secondly, I would like to know how robust the POSIX thread
implementation is considered to be.

	Thanks in advance,
		John Malcolmson

-- 
        Phone (978)-536-2391 (malcolmson@jeol.com) Fax (978)-536-2208

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
