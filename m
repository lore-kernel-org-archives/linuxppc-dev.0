Message-ID: <3933E997.994C1FD@motorola.com>
Date: Tue, 30 May 2000 11:17:27 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
CC: linuxppc-embedded post <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC850 and USB
References: <D53137D1F3DDD211A3750800060DA31302B2CCCD@viee122a.erd.siemens.at> <392D6561.1B8E04BC@embeddededge.com> <392D8E10.BE49DB66@motorola.com> <392D92D5.43881EFD@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:
>
> Richard Hendricks wrote:
>
> > If not...Then I blame the web gremlins, it should have been there a
> > few weeks back.  (#include <long story about Motorola changing its
> > web>)
>
> Better dig out the story book :-).  I find the Motorola web site (and
> may other vendors) very hard to navigate when trying to find these things.

Mot SPS is trying to migrate to a One SPS Website, which is
supposed to be mot-sps.com.  They took a snapshot of our website
many moons ago.  Of course, while changing the look & feel,
they also want to change the backend and (our) interface to the
servers.  Used to be two servers, one internal and one external.
You did a "Magical Mirror Command" on a Unix box to make the
external the same as the internal.  Now there are three different
servers, the internal, a "staging" server, and the external. I
still don't quite have it figured out, but I do know that
www.mot.com inside the firewall does NOT correspond to www.mot.com
outside the firewall.  On top of that, instead of just letting
us store documents in a .html directory, like sane people, they're
trying to do some kind of Mother of All Document Repositories,
with Magical Automagically Generated Pages, yada yada.

And on top of that, they're making us change to Outlook from
Netscape, and foisting Siebel on us. #include <big long anti-MS
whine>

> > Yet again, I don't speak for the MPC850 team.  But I *do* speak
> > for the MPC823 team (being all of it anyways).  The patch is out
> > there.
>
> Try again.  I couldn't find it with a 'search' either.  At least the
> Netcomm site has a high level engineering support page and you can
> find things from there :-).  My bookmark to that has lasted years now.

Did the URL I give not work?  Fscking 34@!$%#$@^%$#@%^

I'll try it from home and see if it does or doesn't work.

The patch we have should be updated from the previous one.  The
old one had problems when the CPM was heavily loaded.  This one
is supposed to be nicer to other CPM tasks.

> The patch we received was from MSIL a long time ago for early testing,
> and although several people have tried, I don't know anyone that ever
> found it on a Motorola server.  If you are sure it is there and we
> can get it, we will test it to make sure it works and include it in the
> Linux kernel.

Would you like me to email the package to you?

#include <yet another anti-Outlook gripe>

>         -- Dan

--
MPC823 Applications Engineering Development
Get help from other MPC823 customers on the
comp.sys.powerpc.tech newsgroup!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
