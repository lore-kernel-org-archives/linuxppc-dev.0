Message-ID: <001001bfe87e$9e4a8370$0602a8c0@cs.tsinghua.edu.cn>
From: "Wang Yong" <wung_y@263.net>
To: "Kwansuk Kim" <kskim@neowave.co.kr>,
        <linuxppc-embedded@lists.linuxppc.org>
References: <NEBBKFENMLEDKDHMEHPJIEOGCAAA.kskim@neowave.co.kr>
Subject: Re: Is the ramdisk mounted?
Date: Sat, 8 Jul 2000 09:48:27 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


of course the root fs has been mounted. maybe there is something wrong with your shell or
execve() itself.
there is a sequence of execve() at the end of init() and if all these calling fail, a message
will be shown as : 'No init found.  Try passing init= option to kernel.'

w.y.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
