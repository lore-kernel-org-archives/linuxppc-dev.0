Message-ID: <XFMail.990318140314.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <19990318044316.Postino-005954@smtp01.highway.ne.jp>
Date: Thu, 18 Mar 1999 14:03:14 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: Re: egcs-1.1.2-RPM
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have now built and [somewhat] tested EGCS-1.1.2.  You can find [R4] RPMS at:
  ftp://ftp.linuxppc.org/linuxppc/users/gdt/
I've uploaded today:
        redhat/RPMS/ppc/egcs-1.1-2a.ppc.rpm
        redhat/RPMS/ppc/egcs-as-gcc-1.1-2a.ppc.rpm
        redhat/RPMS/ppc/egcs-c++-1.1-2a.ppc.rpm
        redhat/RPMS/ppc/egcs-g77-1.1-2a.ppc.rpm
        redhat/SRPMS/egcs-1.1-2a.src.rpm

Note: these are the same 'vintage' as the previous RPMS.  That means that there are
no "vtable thunks" and that the trampoline code is still awry.  This will not change
until R5 arrives.

Good luck.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
