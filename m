Date: Sun, 16 Jan 2000 11:03:20 -0800
From: "David N. Welton" <davidw@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Cutting edge moved or shifting to .deb?
Message-ID: <20000116110320.A27127@linuxcare.com>
References: <200001161644.RAA14656@appel.flower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200001161644.RAA14656@appel.flower>; from janneke@gnu.org on Sun, Jan 16, 2000 at 05:44:08PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


<debian developer hat>

On Sun, Jan 16, 2000 at 05:44:08PM +0100, Jan Nieuwenhuizen wrote:

> On the other hand, ftp.<cc>.debian.org has stuff such as XFree
> 3.3.6, emacs-20.5 (which is good, I was having a lot of trouble with
> my 20.3 emacs), a recent mozilla-M12, that can be alienised, but the
> glibc seems to be 'stuck' at libc6_2.1.2-5.deb.

Yes, and being an open organization, anyone can participate,
contribute bug fixes, and discuss the state of things on the mailing
lists.  What's more, you get the same environment across all
architectures, which currently include ARM, Alpha, m68k, i386, the
early stages of a mips port, ppc, and sparc.  Most of the non i386
architectures are supported by autobuilder systems which let them keep
up with i386, where most of the development occurs.  And there are a
*lot* of .deb's available.

> On a related, totally off-topic note: I can't seem to find how to
> verify package integrity with dpkg, eg, the equivalent for rpm
> --verify.

Dpkg doesn't work that way, although the capability might be added in
the future.  Ask on the debian lists for details.

> I've setup a partition this summer with a minimal debian
> installation, just to test it out.  But at that time, I had only
> low-bandwidth and deer internet access.  The debian distribution was
> having quite some problems then, and updating by burning a cdrom a
> week didn't really work for me.  Now I'm using that partition to run
> compiles on: I removed all docs and other stuff, so that a lot of
> packages should be reinstalled.  However, `chroot /mnt/debian/root
> dpkg --audit', and `dpkg --status <some-doc-truncated-package>' say
> all is ok?  How to fix and upgrade this?

Well, if your packages are out of date, you can just grab all the
latest ones, which should reinstall all the necessary files that have
been wiped.  That's a good place to start, at least.

You really want to get 'apt' up and running - it's fantastic!  It
allows you to run commands like "apt-get install emacs20" and it will
go fetch emacs off the net for you and install it.  If you currently
have apt on there, you can run "apt-get update", and "apt-get
dist-upgrade", and that should get you the latest versions of
everything.

</debian developer hat>

Good luck,
-- 
David N. Welton, Developer, Linuxcare, Inc.
415.354.4878 x241 tel, 415.701.7457 fax
davidw@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
