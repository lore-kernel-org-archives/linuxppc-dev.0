Date: Fri, 8 Oct 1999 16:02:15 -0700 (PDT)
From: Brad Midgley <brad@turbolinux.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: OF syntax for quik on RS/6000
Message-ID: <Pine.LNX.4.10.9910081556350.30742-100000@web1.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Could someone help me with some forth syntax?

Quik on CHRP assumes it will find a devalias "disk" which refers to the
boot disk. However, recent IBM firmware revs appear to disregard setting
that alias, so they can't be booted from hard drive (eg the f50 I'm
working with). I'd like to be able to direct people to enable some nvramrc
code so "disk" is set to be the same as the first entry from boot-device.
(We could try to get fancy later).

How would I express that in OF/forth?

Brad
brad@pht.com | http://www.pht.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
