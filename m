Date: Mon, 19 Jun 2000 07:57:13 +0200
From: Olaf Hering <olh@suse.de>
To: khendricks@ivey.uwo.ca
Cc: linuxppc-dev@lists.linuxppc.org,
        yellowdog-general@lists.yellowdoglinux.com
Subject: Re: Need for Cross Platform Updates Distribution
Message-ID: <20000619075713.A25220@suse.de>
References: <394D2013.AAD184AB@golden.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <394D2013.AAD184AB@golden.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jun 18, hendricks wrote:


> My idea is that the iso-image (identical) would be available from all
> distributions and also sold for some small fee by all distributions.
>
> I can create all of the JDK binaries, I am building the kde2 beta 2
> stuff as I write this, I have all the GNOME Helix 1.2 binaries and
> srpms, Jack has the XFree 4.0 rpms and srpms with the latest G4/Rage 128
> Pro fixes in place, I have the Xpmac source (and some changes from
> Ryuichi to integrate), I have access to alot of patches (both from
> Blackdown and Sun) that fix serious bugs in OpenMotif 2.1, Franz already
> has posted his latest tool chain, and Paul's 2.2.16 rsync kernel is
> available right now.  I also have the cvs from last night of Mozilla and
> will build it this week.
>
> All of this would be available for some sort of joint effort to quickly
> get out an updates CD for everyone to use.
>
> What do people think?  Is this stealing too much thunder from thenext
> distributions releases?  If not, I say let's do it.

The idea is good, but it will not work because every distro has its own
filesystem structure. As example, we put everything under
/opt/{kde,gnome}, the RedHat based distros somewhere under /usr. Another
problem is the naming convention of the rpm files. We have a rpms with
maximal 8 chars and this will lead to problems when upgrading the stuff.
You can not mix that or your rpm database becomes useless.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
