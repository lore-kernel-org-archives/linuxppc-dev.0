Date: 11 Apr 2002 02:57:21 -0000
Message-ID: <20020411025721.26161.qmail@mailFA2.rediffmail.com>
MIME-Version: 1.0
From: "sanjay k k" <fren00@rediffmail.com>
Reply-To: "sanjay k k" <fren00@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ROOT-NFS problem for PPC440 kernel!
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I build the kernel for PPC440 from linuxppc_2_4_devel tree.  I was
able to dowanload the image in ebony board but when it tries to
mount the root file system via NFS, it choked. Here is the message
it gives on console:

*****************************************
Looking up port of RPC 100003/2 on <server IP>
portmap: <server Ip> not responding, times out
Root-NFS: Unable to get nfsd port number from the server,using
defualt

It tires 3 time berfore it reboots itself,

Does any body has anu clue on this?
Thankx
Sanjay


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
