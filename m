Message-ID: <20000129040432.27295.qmail@web3506.mail.yahoo.com>
Date: Fri, 28 Jan 2000 20:04:32 -0800 (PST)
From: Denis BEURIVE <linux_ppc_user@yahoo.com>
Subject: GCC cross compiler ix86/linux => ppc/linux
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi every body,

I am trying to build GCC as a cross compiler from a
"ix86/linux" host to a "ppc/linux" target. And I want
to use the libraries from the LinuxPPC distribution.

To specify the target for GCC I am using the flag:
--target=powerpc-unknown-linux-gnu

-->> Is it the rigth value for the "target" flag ? (I
can't find any other value for this flag that contains
"powerpc" and "linux").

-->> Did anybody have already build the same cross
compiler ?

Thank you very much; any help will be greatly
appreciated.

Best regards,

Denis BEURIVE

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
