Message-ID: <37A28F69.94F9A7D0@generation.net>
Date: Sat, 31 Jul 1999 01:53:45 -0400
From: Simon Piette <spiette@generation.net>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: CD-ROM players keeps an empty CD drive busy.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Did anybody notice that with most cdplayers (kscd, gtcd, wmcdplay, etc),
an empty CD drive generate a lot of kernel messages in syslog and dmesg?
In fact, after a few minutes, forget about fetching info with dmesg:
it's full of "sr0: CDROM not ready.  Make sure there is a disc in the
drive." It generate those messages about 5/10 times a second!! xplaycd
doesn't do that. Is the problem coming from each apps, or from the
kernel?

Simon

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
