Message-ID: <20020920202109.14386.qmail@kunk.jriver.com>
Subject: Re: cdrecord, cdrdao failing with scsi bus reset
In-Reply-To: <20020920200528.14119.qmail@kunk.jriver.com>
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 20 Sep 2002 15:21:09 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


DAO doesn't work with the stock scsi drivers (at least not through
2.4.18). You need to apply a patch to the kernel drivers to get
it working otherwise use tao.

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
