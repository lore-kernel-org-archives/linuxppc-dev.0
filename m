From: Keith Owens <kaos@ocs.com.au>
To: linuxppc-dev@lists.linuxppc.org
Subject: Where does ppc define __start___ksymtab?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Aug 2000 16:40:49 +1000
Message-ID: <28827.965112049@ocs3.ocs-net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Please cc: kaos@ocs.com.au on replies, I am not on this list.

I have been trying to find where ppc defines __start___ksymtab and
__stop___ksymtab symbols.  These delimit the __ksymtab entries for
module symbols.  On every other architecture that supports modules,
arch/xxx/vmlinux.lds contains lines like this

  __start___ksymtab = .;	/* Kernel symbol table */
  __ksymtab : { *(__ksymtab) }
  __stop___ksymtab = .;

I can find no equivalent lines for ppc in a stock 2.4.0-test5 source
tree yet ppc obviously defines them somewhere.  But where?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
