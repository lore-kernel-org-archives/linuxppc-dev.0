Date: Mon, 19 Jun 2000 01:33:38 -0600 (MDT)
From: Bryan Stillwell <arcane@verinet.com>
Reply-To: arcane@verinet.com
To: yellowdog-general@lists.yellowdoglinux.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Need for Cross Platform Updates Distribution
In-Reply-To: <20000619075713.A25220@suse.de>
Message-ID: <Pine.LNX.4.10.10006190106010.30352-100000@bamboo.verinet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 19 Jun 2000, Olaf Hering wrote:

> The idea is good, but it will not work because every distro has its own
> filesystem structure. As example, we put everything under
> /opt/{kde,gnome}, the RedHat based distros somewhere under /usr. Another
> problem is the naming convention of the rpm files. We have a rpms with
> maximal 8 chars and this will lead to problems when upgrading the stuff.
> You can not mix that or your rpm database becomes useless.

Why is that?  It pisses me off that rpms for one distro won't work with
another distro.  It's like the same work is always being done 5 times more
than necessary.  I've never used suse personally, but I've tried using a
suse rpm witha redhat installation and it just screwed everything up.
Same thing happen to me when trying to use a Mandrake rpm...  Why are the
Linux distro companies fighting over something as simple as packaging
format?  Also, what's this about suse using /opt for kde and gnome?  Isn't
/opt in the filesystem standard for commercial software only?

Just my good old $.02 worth.  My frustrations with the different distros
fighting each other has caused me to switch to Debian...  Now if only
there was a company that would make a Linux distro based off of Debian but
would maintain package compatibility with the main Debian tree, I would
probably throw a far bit of money their way.  :)  (Corel Linux just
doesn't do it for me, and Storm Linux is quite a bit out of date the last
I checked.)  My feeling is that rpms have split too much down alternate
paths to try and save them now...  It's nice to know that the Debian folk
have now ported most of the packages to the ppc platform imo.

I guess my main question for writing this message is will the various
distros (Yellowdog, linuxppc, suse, etc.) ever get package compatibility
where I can use a rpm from suse and install it on a yellowdog box?  or
will Debian be the best choice for me in the near/distant future for any
platform?

Bryan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
