Message-ID: <005301c47afc$d2599510$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20040805042134.41548.qmail@web15610.mail.cnb.yahoo.com> <004101c47af6$3f8d8800$0301a8c0@chuck2> <1091717309.4383.4625.camel@hades.cambridge.redhat.com>
Subject: Re: How to remove JFFS2 'Making dirty' display on RPXlite DW?
Date: Thu, 5 Aug 2004 10:59:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, I've done it.  Dumb luck?  eraseall, then the command as shown, but I
don't remember the rest of the options.
I was just playing with jffs2 to compare performance.  I know I got a
mountable, bootable, read/write-able file system,
but wasn't extensively tested.  Actually, I did a fair amount of add/deletes
in order to guage mount time slowdown...

Mark Chambers

----- Original Message -----
From: "David Woodhouse" <dwmw2@infradead.org>
To: "Mark Chambers" <markc@mail.com>
Cc: "Song Sam" <samlinuxppc@yahoo.com.cn>;
<linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, August 05, 2004 10:48 AM
Subject: Re: How to remove JFFS2 'Making dirty' display on RPXlite DW?


> On Thu, 2004-08-05 at 10:12 -0400, Mark Chambers wrote:
> > BTW, I've been able to skip a step by just:
> >
> > mkfs.jffs2  -o /dev/mtd3
>
> It would be cute if someone would make that work as expected -- get the
> right blocksize, erase and prepare the remainder of the device, etc.
>
> We haven't done it yet though.
>
> --
> dwmw2
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
