Message-ID: <3933F017.126FD520@claudio.ch>
Date: Tue, 30 May 2000 18:45:11 +0200
From: Claudio Nieder <private@claudio.ch>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: yaboot lockups (IBM travelstar)
References: <Pine.LNX.4.20.0005300927020.16755-100000@mail.turbolinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> I just put a 12gig IBM drive in my bronze powerbook. Now, if I try to
> coldboot using yaboot, the kernel locks up just after it prints out that
> it discovered the ide controllers. I don't think this was happening with

I have a bronze powerbook 400MHz with 6 GB disk. When I started to use
yaboot (0.6) with my 2.2.15pre9 kernel it would hang as soon as it printed
first line that wouldn't fit on the screen, i.e. when it had to scroll the
display. I remember Benjamin writing to this list once, that the bronze
powerbook is the one new world machine, which is not yet fully supported
by yaboot, and cold booting through BootX is a must.

				claudio
--
Claudio Nieder, Kanalweg 1, CH-8610 Uster ,'`.,'`.,'`.,'`.,'`.,'`.,'`
mailto:private@claudio.ch http://www.claudio.ch phone:+41 79 357 6743

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
