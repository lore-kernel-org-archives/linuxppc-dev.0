Reply-To: "Todd Inglett" <tinglett@vnet.ibm.com>
Message-Id: <3A1A7C2C.40BB3344@vnet.ibm.com>
Date: Tue, 21 Nov 2000 07:44:12 -0600
From: Todd Inglett <tinglett@vnet.ibm.com>
Mime-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: bitops porting question
References: <3A1A6E42.43E8663D@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Todd Inglett wrote:
>
> Anyway, the gist of the problem is that when sizeof(int) != sizeof(long)
> the operations break down for one reason:  there is no test_bit()
> function.

For some dumb reason I didn't notice that there really *is* a
test_bit().  But not all code uses it :(.  For example, the b_state
flags in the generic block driver interface doesn't use it.

--
-todd

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
