Message-ID: <38BC8F25.7CDC484@huawei.com.cn>
Date: Wed, 01 Mar 2000 11:31:49 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: crossgcc@sourceware.cygnus.com,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Reduce glibc libraries...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
      I have a problem to ask when applying embed-linux in our product.
      Since our application may need many share libraries when running,
and most of these libraries seem to be too large: libc.so.6 is about
1.5M, and the ld.so.1 is about 180K, and there are still other
libraries...
       If I put the linux kernel and root-fs in my flash(about 2M), I am
fear that there may be no enough space to hold all of them. So do I have
to modify and remove any unuseful sources from the glibc libraries to
reduce the size of libraries I need? But it is too difficult. So what's
your suggestions or alternative  methods ?  Does it make any difference
if I compile my application with static-link options "-s"? Are there
someone to do these jobs now?
       Thank  you very much:-)
       dony

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
