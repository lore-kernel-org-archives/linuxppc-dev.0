In-Reply-To: <19991225012811.003886>
Date: Sat, 25 Dec 1999 12:41:52 +0100
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: OF simple boot chooser
Message-Id: <19991225124152.015787@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Dec 25, 1999, BenH <bh40@calva.net> wrote:

>" Booting MacOS ..." cr " boot hd:,\\:tbxi" eval
>else
>" Booting Yaboot ..." cr " hd:,\\yaboot" eval

Note: It appears that the syntax above doesn't work on all newworld
machines. You should precice the partition number:

" Booting MacOS ..." cr " boot hd:9,\\:tbxi" eval
else
" Booting Yaboot ..." cr " hd:9,\\yaboot" eval

Will tell OF to look for the ROM image and yaboot in the system folder of
partition 9.

I'll try to write some tool for automatically creating this file, but it
will probably be a MacOS-based tool and may require a recent version of
MacOS (9.0 ?). Older versions of MacOS didn't provide a clean way to
figure out the OF path of a device.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
