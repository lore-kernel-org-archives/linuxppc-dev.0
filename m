Message-ID: <3967B1E3.80CAC746@embeddededge.com>
Date: Sat, 08 Jul 2000 18:57:39 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Help with string.S
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I found the source of the 4xx and 8xx troubles in the 2.4.xx kernel.
The functions in arch/ppc/lib/string.S are broken for anything other
than 32-byte cache lines.  I am making the changes, but it would be
nice to have someone else look at this as well.  There are lots of
assumptions outside of the apparent parameters that the cache is
32-bytes.


Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
