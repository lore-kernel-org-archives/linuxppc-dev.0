Message-ID: <20020218084214.48551.qmail@web9701.mail.yahoo.com>
Date: Mon, 18 Feb 2002 00:42:14 -0800 (PST)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: USB in RPXLITE 823
To: Sarnath Kannan <sparc64@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020218071112.18296.qmail@mailweb19.rediffmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Well, I have come to that message too, but for 8260.
Although it doesn't seem correct, when I didn't
config the pins through linux (but through ppcboot)
everything went ok. It seems that when I configured
Port C, I lost ethernet (ethernet had some pins on
port C). I dont know if this is related, but just a
hint. (I also used 2.4.7 kernel)

                   D. Meidanis

--- Sarnath  Kannan <sparc64@rediffmail.com> wrote:
>
> I compiled the Monta 2.4.2 kernel with USB support
> and run it on RPXLite with MPC 823. The kernel
> panicked.
>
> I wanted to test the USB part alone. Hence i copied
> the usb.c to arc/ppc/8xx_io and m8xxhci.c to
> drivers/usb
> and made appropriate changes to kernel config.in
> files
> and tried to compile it (i did these to 2.4.7 tree).
> When i do this the kernel comes up and when it tries
> to
> NFS mount the root file system
> it hangs (or) stalls , i dont know.
>
> Am i missing something ?
> Or am i doing something terrible wrong ?

=====
-------------------------------------------------
  Dhmhtrios Meidanis
-Degree in Mathematics, University of the Aegean.
-Master in Computer Architecture and Digital
 Systems, University of Crete.
  Greece.
-------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
