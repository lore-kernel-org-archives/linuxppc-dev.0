Message-ID: <394DD3D2.4A93B5E@wibble.net>
Date: Mon, 19 Jun 2000 18:03:30 +1000
From: Steven Hanley <sjh@wibble.net>
MIME-Version: 1.0
To: arcane@verinet.com, Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Need for Cross Platform Updates Distribution
References: <Pine.LNX.4.10.10006190106010.30352-100000@bamboo.verinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Why is that?  It pisses me off that rpms for one distro won't work with
> another distro.  It's like the same work is always being done 5 times more
> than necessary.

well the snide answer form me would be because redhat is broken or at
least braindead in how they structure the system and thgus Suse had to
fix it up. It probably isnt that bad but hey.

> I've never used suse personally,

I have and quite happily admit if debian didnt exist suse would be my
preferred distribution. I never feel as if suse is quite so braindead
when sitting at a suse box as I do at redhat to some degree and
definitely at mandrake (the few times I have had to admin mandrake
machines have been painful, though this all again can be attripted to
the fact I am used to debian.)

> but I've tried using a
> suse rpm witha redhat installation and it just screwed everything up.
> Same thing happen to me when trying to use a Mandrake rpm...  Why are the
> Linux distro companies fighting over something as simple as packaging
> format?  Also, what's this about suse using /opt for kde and gnome?  Isn't
> /opt in the filesystem standard for commercial software only?

well all the major distributioons AFAIK have said they would start
standardising around the recent LSB standards (2.* versions of the
standard) that were released. All that is except slackware, but then
thats slackware for you (I will refrain form saying more).

Interestingly of course you will note the recent standards I just
mentioned are closer to what debian looks like today than any other
distribution. :)

>
> Just my good old $.02 worth.  My frustrations with the different distros
> fighting each other has caused me to switch to Debian...  Now if only
> there was a company that would make a Linux distro based off of Debian but
> would maintain package compatibility with the main Debian tree, I would
> probably throw a far bit of money their way.  :)  (Corel Linux just
> doesn't do it for me, and Storm Linux is quite a bit out of date the last
> I checked.)  My feeling is that rpms have split too much down alternate
> paths to try and save them now...  It's nice to know that the Debian folk
> have now ported most of the packages to the ppc platform imo.

well this is a good thing debian are doing (yet more good things) the
next generation package management library they have been working on for
the last year or so is aimed at beingg able to handle any package
formats from the different distributions, not only deb format. I dont
actually know if this new system will be in woody or not though.

> I guess my main question for writing this message is will the various
> distros (Yellowdog, linuxppc, suse, etc.) ever get package compatibility
> where I can use a rpm from suse and install it on a yellowdog box?  or
> will Debian be the best choice for me in the near/distant future for any
> platform?

well currently of course suse has still not released their ppc
distribution. this is unfortunate in my eyes as I am still stuck with
yellowdog on my ppc box. I also cant get debian ppc cds anywhere yet
which would solve my problems for good (putting debian on the ppc box I
have) and as in this country we pay 19c/MB for download and no one can
easily get a connection faster than a modem I dont really want to
install of the net, even with apt making the whole process so incredibly
trivial.

I suppose that would be my input in the friendly local distribution war
scheduled for today....

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
