Date: Wed, 9 Oct 2002 11:12:36 -0400
Subject: Status of 2.5.X kernels on PPC Linux, anyone working with NPTL?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: yellowdog-devel@lists.terrasoftsolutions.com
To: linuxppc-dev@lists.linuxppc.org
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Message-Id: <8B16CEB0-DB99-11D6-BCE2-0030654D6A26@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Can anyone bring me up to date on the buildability and useability of the
latest 2.5.X kernels on PPC Linux?  How stable and useful are these
given the recent changes to revert back to 2.4 IDE code and other
changes?

Also, is anyone here actively working on Ulrich Drepper's New Posix
Thread Library (NPTL) to add in support for ppc Linux?  Has anyone
decided on what register will be used for Thread Local Storage on PPC
(32bit)?  (Is this r13 on ppc64?).  Have the necessary modifications to
the ABI/compiler been made to support a dedicated thread local storage
register?

Any hints or guidance greatly appreciated?

Thanks,

Kevin

----
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London Ontario, CANADA  N6A 3K7
khendricks@ivey.uwo.ca


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
