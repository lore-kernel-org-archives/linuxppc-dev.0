Date: Sun, 16 Jan 2000 18:03:39 -0500 (EST)
From: satadru pramanik <satadru@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: aic7xxx config errors in 2.2.14, but not in 2.2.7
Message-ID: <Pine.SOL.4.10.10001161756390.16172-100000@galaga.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am using the stock vmlinux.2.2.7-vger kernel to enable support for my
Adaptec 2940 and 2940u2w scsi cards in a powermac 7600 using OF booting.


When I do a cvs sync with the current 2.2 linux ppc tree i heard about on
the mailing list, and then did an update ( cvs update -rlinux_2_2), and
recompiled and tried a kernel with the aic7xxx option selected, only one
of the adaptec cards is recognized.

Have there been significant changes to the aic7xxx driver in the past
several months?   How would I get an old version of the aic7xxx driver as
in the 2.2.7 vger kernel?

Any reconfiguration info would be appreciated.

thanks.


----
satadru pramanik www.umich.edu/~satadru
Do, or do not.  There is no try.
-Yoda
---


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
