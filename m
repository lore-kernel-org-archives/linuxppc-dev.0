Date: Tue, 30 May 2000 09:33:57 -0700 (PDT)
From: Brad Midgley <brad@turbolinux.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: yaboot lockups (IBM travelstar)
Message-ID: <Pine.LNX.4.20.0005300927020.16755-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just put a 12gig IBM drive in my bronze powerbook. Now, if I try to
coldboot using yaboot, the kernel locks up just after it prints out that
it discovered the ide controllers. I don't think this was happening with
the old 4gig drive.

I have to use bootx if I'm booting the machine cold. yaboot works for warm
boots.

Using paul's rsync 2.2.15, yaboot 0.6.

Brad
Turbolinux Frontier Group
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
