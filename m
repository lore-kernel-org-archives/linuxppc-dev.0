From: "Bob Piatek" <bobtek@fishcamp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "'Tom Rini'" <trini@kernel.crashing.org>
Subject: RE: unresolved symbol
Date: Mon, 31 Dec 2001 14:47:28 -0800
Message-ID: <000501c1924d$1fd40410$a2341204@P4>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20011231153213.GB28513@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom,

I'm using YellowDog Linux 2.1 for my development system.  I don't think
the modutils update is needed for 2.1 and, indeed, I can compile and
'insmod' modules on my host system just fine.

My problem is that I can't load modules on my embedded system.  Sorry I
wasn't clear about that in my posting.  I am using the kernel from:

ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2001-11-24.tar.bz2

and ramdisk:

ftp://ftp.denx.de/pub/LinuxPPC/usr/src/simple-ramdisk.image.gz

and have ported it to my custom hardware running with an MPC860.  BTW...
thanks to all who have contributed software for this effort especially
the PPCBoot project!

Correct me if I'm wrong, but it looks like the problem is caused by the
kernel not exporting the symbols that are needed by the module and not
in the actual module itself.  Is it that I built the kernel wrong
somehow, or maybe the libraries in 'simple-ramdisk' image aren't
sufficient, or is it something else?

Bob


fishcamp engineering
105 W. Clark Ave
Orcutt, CA  93455
TEL: 805-937-6365
FAX: 805-937-6252


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of Tom
Rini
Sent: Monday, December 31, 2001 7:32 AM
To: Bob Piatek
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: unresolved symbol


On Sun, Dec 30, 2001 at 05:02:43PM -0800, Bob Piatek wrote:

> When attempting to load a module via 'insmod' I get the following:
>
> insmod unresolved symbol kmalloc
> insmod unresolved symbol unregister_chrdev
> insmod unresolved symbol register_chrdev
> ...
> insmod unresolved symbol printk
>
>
> It seems that there was another person with the same problem on Sept
24,
> 2001 to this list.  However, the solution to the problem was not
posted
> to the list.

It sounds like you're running YellowDog Linux 2.0, and thus need to
install the modutils update.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
