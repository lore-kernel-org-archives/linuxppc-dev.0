From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16076.21054.438454.226554@argo.ozlabs.ibm.com>
Date: Thu, 22 May 2003 14:29:50 +1000
To: Ira Weiny <iweiny@acm.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Machine Check question
In-Reply-To: <20030423213856.1a41d143.iweiny@acm.org>
References: <20030410013241.3ae349e5.iweiny@acm.org>
	<16021.61655.348425.683335@nanango.paulus.ozlabs.org>
	<20030423213856.1a41d143.iweiny@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ira Weiny writes:

> Is this only on the TiBooks?
>
> Why would this not be a problem on other pmac laptops?
>
> BTW, this is a TiBook.

The problem arises when you have an IDE interface with no attached
drives.  Whether this happens depends on the chipset, so it could be a
problem on other pmac laptops.  Ben H. has a patch to fix the problem
which he is trying to get accepted.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
