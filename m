Return-Path: <GRuescher@dspace.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Problem cloning Linus' GIT tree!
Date: Tue, 17 Apr 2007 15:09:44 +0100
Message-ID: <18A49CF3586FC14290887ECC63C9141F0104D047@exchange2003.dspace.de>
In-Reply-To: <200704171228.56848.laurent.pinchart@technotrade.biz>
From: "Gerald Ruescher" <GRuescher@dspace.de>
To: <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Laurent,

> > After a while however, git exits with the following error message:
> >
> >    error: Couldn't get =
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ref=
s/tags/v2.6.11 for tags/v2.6.11=20
> >    The requested URL returned error: 404
> >    error: Could not interpret tags/v2.6.11 as something to pull
> >    rm: cannot remove directory
> >   `/cygdrive/c/home/git/linux-2.6/.git/clone-tmp': Directory not =
empty
>
> Try upgrading git to the last version.

I'm already using the latest version (1.5.1) of git but the error still =
persists.
A "http 404" error usually reports that something is missing on the =
server.
In fact, if I copy the URL above to web browser, the same error occurs.

Question:=20

Do=20
	git://git.kernel.org=20
and	http://www.kernel.org		<-- Note the *www*(!)

physically access the same repository?  Or is the http server maybe just
a mirror of the git server (which could mean that the two could be out =
of sync)

If all fails I could harass our company's network admins to open
the git port in the firewall :-) but I'd prefer to fetch the tree
via http.

Any advice?  Is there anyone else who is using Linus' tree via http?

Many thanks and kind regards,
Gerald



_______________________________________________

Gerald R=FCscher
Software Development Engineer
Core Real-Time Implementation

dSPACE GmbH          Tel.:  +49 5251 1638-1826
Technologiepark 25   Fax:   +49 5251 16198-1826
33100 Paderborn      http://www.dspace.de
Germany              mailto:GRuescher@dspace.de
_______________________________________________
