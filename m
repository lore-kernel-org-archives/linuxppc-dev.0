Message-Id: <200001161843.TAA15591@appel.flower>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Cutting edge moved or shifting to .deb? 
In-reply-to: Your message of "Sun, 16 Jan 2000 19:15:15 +0100."
             <38820AB3.72DDCF9F@wanadoo.fr>
Date: Sun, 16 Jan 2000 19:43:30 +0100
From: Jan Nieuwenhuizen <janneke@gnu.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sunday, 16 January 2000, Martin Costabel writes:

> There is some pretty interesting recent stuff in contrib, but have you
> ever thought about contributing yourself? The current versions of gcc

Uhm, that's partly why I'm asking.  I'm contributing LilyPond (see sig),
eg, which I'd like to give the best part of my time.  Also, I don't have
the resourses (disk space) to contribute X11 or Mozilla.  I can't
imagine that I'm the only one (or first one for that matter), wanting a
more stable version of Emacs, for example?

Yesterday, I found that vanilla Emacs-20.5a doesn't easily compile for
ppc (using modified 20.3 patches).  Now, before my (LilyPond) development
efforts grinds to a halt, in favour of maintaining important parts of
my own distribution, I'd just like to know if I'm missing some important
ftp site: will anybody use my emacs-20.5 if I manage to put up an rpm on
contrib, or has everyone already got it from somewhere else?

> and glibc 
> are so stable that you can basically take the latest *.src.rpms or even 
> tgzs from anywhere and compile them with only minor tweaking.

Yes, that's really grand.  So much better than, say, a year ago.

> > On the other hand, ftp.<cc>.debian.org has stuff such as XFree 3.3.6,
> > emacs-20.5 (which is good, I was having a lot of trouble with my 20.3
> 
> ftp.mklinux.org has new RPMS, for example emacs-20.5 RPMS. The latest

Ok, thanks.  Should have posted my questions yesterday :-)

> xemacs versions (both stable and devel) also exist as RPMS or are easily
> compilable.
> 
> And then it looks like a major new release from linuxppc.com is
> imminent...

I've been expecting this for some time, but how can one tell?

> > emacs), a recent mozilla-M12, that can be alienised, but the glibc seems
> > to be 'stuck' at libc6_2.1.2-5.deb.
> > 
> > Kernel development seems to have moved from vger to openprojects to
> > Paul's at linuxcare: rsync -auvz linuxcare.com.au::linux-pmac-devel.
> 
> Vger is quite alive in recent days. I have their kernel versions
> 2.2.15-pre2
> and 2.3.40 (pre something), both running OK for me.

Ah.  I tried some days ago, and it had the same problems with pmac_nvram.c
(missing .h include) as Linus' tree.  I'll have another look.

> turbolinux, debian, SuSE (far too much for my taste), I think the amount
> of development coming out of it is rather awesome. 

It is.  But it helps if you know where to look.

Thanks for some pointers,

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
