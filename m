Message-Id: <200110121441.JAA12950@lists.linuxppc.org>
From: "Boerner, Brian" <bmb@pirus.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Using BK under Cygwin
Date: Fri, 12 Oct 2001 10:45:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone been able to get bk to download the kernel sources under cygwin.
I get the following error, which makes sense:

==========================================================================
Sfio has detected a name conflict between
"include/linux/netfilter_ipv4/SCCS/s.i
pt_mark.h" and "include/linux/netfilter_ipv4/SCCS/s.ipt_MARK.h";
This usually happen when you transfer file from a case-sensitive file
system (e.g. Unix) to a case insensitive file system (e.g FAT, NTFS)
Please rename one of the file and retry (see also "bk helptool mv")
==========================================================================
write on fd gzip_in gunzip2fd: Broken pipe
socket2pipe: reader error 2

I tried running the mv command, but when I start the clone again I get the
same error. I'm pretty new to bk so I'm assuming there is a way around this.
We've been stuck on 2.4.1-pre10 for awhile now and I want to investigate
moving forward.

Thanks.

-bmb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
