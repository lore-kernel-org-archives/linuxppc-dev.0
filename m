Message-ID: <000601c2f979$92eba130$11021bac@LocalHost>
From: =?ks_c_5601-1987?B?w9a/tcDP?= <yichoi@Corecess.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: memory problem
Date: Thu, 3 Apr 2003 09:40:06 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to boot with ppc-kernel(2.4.21-pre5)
I'm trying to boot to the platform for our team to develop.
I add some driver to the kernel.
Unhappily, the size of my driver is over 3M bytes.
So, My total kernel size is over 5M(5140376 byte).
Then, My system(440 cpu) can not boot
Just kernel(no my driver or with small size my driver) can boot.
I don't know reason.
 does Linux have limit to kernel size?
Please, let me know why to happen?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
