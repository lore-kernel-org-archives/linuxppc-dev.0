Date: Wed, 31 Jan 2001 19:28:38 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Ron Bianco <ronb@junction.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux 2.4.x, PPC and  openPIC interrupt priorities
Message-ID: <20010131192838.A24209@hq.fsmlabs.com>
References: <20010131170852.D19501@hq.fsmlabs.com> <000801c08bf6$88362780$4d012ac7@warp-speed>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000801c08bf6$88362780$4d012ac7@warp-speed>; from Ron Bianco on Wed, Jan 31, 2001 at 06:27:32PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


} Thanks a lot Cort, that's a big help.
}
} We're wondering if rtlinux-3.0-pre10 patches can also be applied to your latest
} bitkeeper 2.4.1-preX  linux.
} It is mentioned that the patches are to be applied to linux-2.4.0-test1.

You may want to just grab the tar file for the kernel source there.  It's
pre-patched for all architectures.  In fact, the most recent PPC trees need
no patches.  The RTLinux code itself that is there (3.0-pre10) doesn't work
with 2.4.1-preX but we do have a copy that does work.  That'll be in our final
3.0 release (hopefully later this week if our testing goes well).

} It sure is unfortunate, to my mind, that regular linux handles interrupts that
} 'enable all/disable all', way.
} But I understand the predicament of dealing with tons of different PICs.   Must drive
} driver writers nuts. :-)
} Might actually make writing linux drivers for some hardware, impossible.

You can disable/enable interrupts individually but you can't adjust
priorities.  Linux doesn't depend on priorities, either.  Perhaps I wasn't
clear about that.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
