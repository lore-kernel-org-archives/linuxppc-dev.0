Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEB466@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: /dev/console and mknod question
Date: Wed, 9 Oct 2002 22:21:49 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Finally I got the linux work on my custom board. At first I encountered
"unable to open an initial console" problem. I created /dev/console then it
worked.

But I am still wondering how this /dev/console works ? Why mknod (which I
think
is a native intel platform command) can create a device that cross platform
powerpc linux
can understand ?

Thanks.

Bo Yu
Motorola, GTSS
1-817-245-6725


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
