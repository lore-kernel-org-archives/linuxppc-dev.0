Message-ID: <3DBBDC56.AF3500EE@denise.shiny.it>
Date: Sun, 27 Oct 2002 13:30:14 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Status of 2.5.X kernels on PPC Linux, anyone working with NPTL?
References: <8B16CEB0-DB99-11D6-BCE2-0030654D6A26@ivey.uwo.ca>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin Hendricks wrote:

> Also, is anyone here actively working on Ulrich Drepper's New Posix
> Thread Library (NPTL) to add in support for ppc Linux?  Has anyone
> decided on what register will be used for Thread Local Storage on PPC
> (32bit)?  (Is this r13 on ppc64?).  Have the necessary modifications to
> the ABI/compiler been made to support a dedicated thread local storage
> register?

Ehm, sorry for my silly question, but why it is necessary to keep
a register reserved for TLS ?  Where can I find detailed infos about TLS ?


Bye.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
