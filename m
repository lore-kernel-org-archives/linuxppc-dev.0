Message-ID: <B25E2E5A003CD311B61E00902778AF2A039C353D@SERVER1>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Generating core files when user apps crash
Date: Wed, 12 Dec 2001 09:01:19 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am using linux 2.4.4 on my board, what I have seen is when user
applications crash
they are not generating core files. I have made sure that ulimit for the
core file is set to
unlimited, using ulimit -c unlimited

Is there something else I need to do to generate core files when programs
crash?

sh-2.04# ulimit -a
core file size (blocks)     unlimited
data seg size (kbytes)      unlimited
file size (blocks)          unlimited
max locked memory (kbytes)  unlimited
max memory size (kbytes)    unlimited
open files                  1024
pipe size (512 bytes)       8
stack size (kbytes)         8192
cpu time (seconds)          unlimited
max user processes          8192
virtual memory (kbytes)     unlimited


/Subodh Nijsure


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
