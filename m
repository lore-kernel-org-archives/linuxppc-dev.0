From: bob@kunk.jriver.com
Message-ID: <20001107175900.6617.qmail@kunk.jriver.com>
Subject: Re: controlfb and X
To: flar@pants.nu (Brad Boyer)
Date: Tue, 7 Nov 2000 11:59:00 -0600 (CST)
Cc: mlan@cpu.lu, bob@kunk.jriver.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20001107070546.08EF32B54A@marcus.pants.nu> from "Brad Boyer" at Nov 06, 2000 11:05:45 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Brad Boyer says:
>
> There's been a long standing issue on detecting the full 4M on controlfb
> that regularly pops up. I happen to have a 7600 with the video upgraded to
> 4M, so I've been interested in this as well. I've seen several patches
> float over the list, and I don't think any of them actually worked for
> everyone. I believe the conclusion was that control just didn't act the
> same on every machine. I suspect that if you look back through the list
> archives, you'll find lots of discussion on this topic.
>
> 	Brad Boyer
> 	flar@pants.nu
>
> P.S.: Try the following search on lists.linuxppc.org in linuxppc-dev:

Brad,
I've done the search already. That is how I found out that Michael has
been working on it.

What it boils down to is this:
2 trees, one the stable(2.2) and dev(2.4) paulus sources.

The memory detect/override/dma changes do not appear to be
 in the stable tree.

Without being able to override the video mem from 2 to 4 megs in
the stable tree, I can't test that kernel version with XF68_FBdev

Using the dev kernel, the override works and the text mode change
to mode 17,32 (which requires more than 2 megs) works but both
Xfree 3.6 and 4.01 lock up trying to do 24/32 bit mode.

I'm trying to give feedback and to see if Michael or anyone else has
ideas about other things to test to pin the problem down further.


Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
