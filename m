Message-ID: <01C1CE68.2B0282B0.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: apps and interrupts
Date: Mon, 18 Mar 2002 10:32:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Using a kernel timer interval interrupt, what is the fastest way
to have my app recognize that the interrupt occurred, with the
shortest delay time possible between interrupt and the app
recognition?  Isn't using the select() approach rather slow?

Thanks,

ShutEye Thinkin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
