Date: Tue, 24 Aug 1999 14:35:33 +1000
Message-Id: <199908240435.OAA05026@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: linuxppc-dev@lists.linuxppc.org
In-reply-to: <19990823163610.A31129@mango.genunix.net> (message from anthony
	tong on Mon, 23 Aug 1999 16:36:10 -0500)
Subject: Re: BootX enhancement request
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.SGI.4.00.9908231613030.7470-100000@osiris.office.aol.com> <Pine.BSF.3.96.990823162311.86405K-100000@silver.teardrop.net> <19990823163610.A31129@mango.genunix.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


anthony tong <atong@uiuc.edu> wrote:

> If you have a version of MacOS that saves the monitor mode in nvram,
> you shouldn't need to give any kernel arguments. Alternatively you
> can use the linuxpmac tool nvvideo to set this.

Yep.  There are two problems at the moment, which I should get off my
butt and fix. :-)

The first is that the current machines use a different structure for
nvram, based on the CHRP spec, which means that just using a fixed
offset in nvram doesn't work.  In fact it seems like macos adds a OF
property with a really strange encoding to store arbitrary bits of
information for the device drivers for arbitrary devices.

The second is that macos is now using mode numbers > 20.  I haven't
worked out the correspondence yet.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
