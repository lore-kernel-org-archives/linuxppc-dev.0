Message-ID: <20000404002128.28700.qmail@web1005.mail.yahoo.com>
Date: Mon, 3 Apr 2000 17:21:28 -0700 (PDT)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: read-only root (was Re: Help I've been cracked!!!)
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- Greg Noel <GregNoel@san.rr.com> wrote:
>
> At 7:33 AM -0500 4/2/00, Justin Shore wrote:
>
> >... has anyone ever setup [sic - that's a noun, you want "set up"] a
> >system where root was on CD or some other non-writable volume ... ?

	Any host acting as a network appliance, such as a router or firewall,
should do that.  Linux Router Project does that.  You can have a
read-only boot medium such as cdrom, floppy, or hard drive.  Hopefully,
it's physically read-only like a cd or a jumpered hard drive.  To deal
with logs, I suggest the following:

* A ramdisk filesystem for logs, periodically emailed to you and then
deleted by logrotate

* a completely read-only filesystem with a network-based syslog host
for security

* Or just no logs at all.

	Also note that Yggdrasil's "Plug and Play Linux" distribution can
optionally boot completely off the cdrom.

=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
