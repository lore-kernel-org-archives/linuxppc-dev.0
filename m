Message-ID: <394DE1CA.509F24DC@amulet.co.jp>
Date: Mon, 19 Jun 2000 18:03:06 +0900
From: Hollis Blanchard <hollis@amulet.co.jp>
MIME-Version: 1.0
To: Michel Ddnzer <daenzerm@student.ethz.ch>
CC: arcane@verinet.com, yellowdog-general@lists.yellowdoglinux.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Need for Cross Platform Updates Distribution
References: <Pine.LNX.4.10.10006190106010.30352-100000@bamboo.verinet.com> <394DD78F.AD49931@amulet.co.jp> <394DDB66.62A97110@student.ethz.ch>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel D wrote
> Hollis Blanchard wrote:
> >
> > I look at that as trying to install an OS/2 binary onto a Windows box
> > (and then complaining that it doesn't work).
>
> Huh??? We are speaking about the same binaries for the same OS, but packaged
> in an incompatible manner.

Yes, and from two completely different companies.

Of course you usually *can* get a foreign rpm to install, it's just that
it's not unusual for it not to work with your system (or may break other
things in your system). Since neither company is testing their software
packages for compatibility with the other, this is not unexpected.

> > > Also, what's this about suse using /opt for kde and gnome? sn't
> > > /opt in the filesystem standard for commercial software only?
> >
> > It all depends on what "standard" you're using.
>
> Check out FHS (http://www.pathname.com/fhs/), which is an affiliated project
> of The Free Standards Group.

Ah, there it is. linuxbase.org needs to be a little better about
organizing their website it seems...

Getting back to /opt, it seems "The use of /opt for add-on software is a
well-established practice in the UNIX community." "Distributions may
install software in /opt, ..." blah blah blah.

It should be noted that this is just one standard, and on top of that a
standard only has strength if enough folks adhere to it. (Of course I
don't know of any others for Linux, and I think most distributions have
said they "will" adhere to it, whatever that means...)

> > I should also note that Debian packages also don't work well with other
> > distributions.
>
> But at least there aren't incompatible flavours of debs - you find a deb
> somewhere, you install it, it works.

Debian is of course a single organization (and honestly I don't know
anything about Corel or Storm or any compatibility issues there - isn't
Corel using an old glibc?). If only RedHat used RPM, you can bet any rpm
you could find would work.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
