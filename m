Date: Thu, 22 Jun 2000 13:50:14 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
To: "Mark S. Mathews" <mark@absoval.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
In-Reply-To: <Pine.LNX.3.96.1000622130831.10550A-100000@tristar.cc.absoval.com>
Message-ID: <Pine.LNX.4.21.0006221346020.5278-100000@sunapee.transcept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Mark!

Hint: if you are going to program the flash you don't want to allocate the
amount of memory larger than the file you are going to program. And you
probably don't want to erase the initial loader ;-)

But I agree that the kernel should allow you do that and it doesn't.

Regards,
Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
