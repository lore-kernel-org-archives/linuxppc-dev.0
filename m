Date: Mon, 13 Mar 2000 14:59:50 -0500
Subject: Re: Xfree86 4.0
From: "James B. Parker" <pajama1@mindspring.com>
To: LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B4F2B2E6.152D%pajama1@mindspring.com>
In-Reply-To: <Pine.LNX.4.10.10003131953540.6906-100000@opal.biophys.uni-duesseldorf.de>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


<snip> from schmitz@mail.biophys.uni-duesseldorf.de on 3/13/00 1:59 PM

> You'll need to create a new XF86Config (XFree86 -configure should, in
> theory, do that).
> Depending on your kind of video hardware, XFree 4.0 will just not work at
> this time. I spent the last few days debugging the X server on my Lombard
> and almost trashed my installation in the process. It seems with the new
> XFree release, the X server on PPC finally became equally unstable as the
> Intel one :-)
> Michael
>
>

Actually, I do have a XF86Config file.  After the build/install I ran
Xconfigurator (it finally recognized 6mb of vram) and then just skipped the
test section.

BTW, my video hardware is the basic rage pro found in rev. 2 G3's.  I am
pretty sure Xconfig recognized the chip.  My main problem now is just
solving the "no screens" issue.

So what are screens and where are they located?

James

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
