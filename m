Message-ID: <38686BD8.C0601CD1@huawei.com.cn>
Date: Tue, 28 Dec 1999 15:50:48 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: tftp kernel problems...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all,
      Merry christmas & happy new year :-))
      Now I am working so far to try to embed linux in our MPC 860
board. I have downloaded _etherboot_  package and _fadsrom_ package, and
made some modifications to suit our demands. All the initiations
(including the serial initiation and ethernet initiation ) seem to work
well. Yes, The next step is to download  the kernel from the NFS Server
via BOOTP, TFTP and NFS protocols and then run it. The questions I want
to ask is:

After I download the kernel into RAM , how can I run it according to its
format? The etherboot package seems to run two asm functions "xstart"
and "longjmp". Maybe I should rewrite these two functions in PowerPC asm
language ? but unfortunately I am not familiar with this language. Can
someone with experience help me, please? Or can you point out to me some
samples code you have writen?

Thank you very much :-))
dony


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
