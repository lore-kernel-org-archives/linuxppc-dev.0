Message-ID: <38AA7CE4.1BE02D32@huawei.com.cn>
Date: Wed, 16 Feb 2000 18:33:08 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Problems about gdbserver...
References: <385179C1.F699B552@ittc.ukans.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

     I  have a gdbserver first running on the target board (gdbserever :7777
mytest), and then powerpc-linux-gdb running on the host. When I type "target
remote 10.11.27.244:7777" (10.11.27.244 is the Ip of target board) on the host
"(gdb)" prompt, it shows the error messages:
    Remote debugging using 10.11.27.244:7777
    Couldn't establish connection to remote target
    Remote communication error:Connection reset by peer.
And at the target board side, error messages as follows:
    #./gdbserver :7777 mytest
    Process mytest created; pid=8
    pid 7:killed (signal 11)
    #
Do you know why and how can I solve it?
Thanks very much.
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
