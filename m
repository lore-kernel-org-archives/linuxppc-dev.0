Subject: Why is search_exception_table disabled for modules on PPC?
To: linuxppc-dev@lists.linuxppc.org (Linux PowerPC developers mailing list)
Date: Mon, 10 Apr 2000 19:48:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000410094843.D29FB3C960@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi gang,

Can anyone tell me why arch/ppc/mm/extable.c:search_exception_table only
searches the kernel exception table on PowerPC in 2.2.14?  Why isn't the
per-module table search enabled like on every other architecture?

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
