Date: Mon, 24 Jun 2002 10:53:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: somshekar chandrashekar kadam <ppclinux@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: init problem
Message-ID: <20020624175318.GD3489@opus.bloom.county>
References: <20020624151514.4835.qmail@webmail16.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020624151514.4835.qmail@webmail16.rediffmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 24, 2002 at 03:15:14PM -0000, somshekar chandrashekar kadam wrote:

>    i have created ramdisk image my kernel is able to detect the
> ramdisk when init is run ,its saying
>  attempting to kill init rebooting in 180 sec
>
> is it problem of some missing  library

Well, it does sound like your initrd isn't correct (it is mounting the
ramdisk fine, but /sbin/init isn't running correctly).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
