Message-ID: <39B2D928.2BCF9CB@m2tech.co.nz>
Date: Mon, 04 Sep 2000 11:05:12 +1200
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: "Johnson, Stephen B." <stevebj@artesyncp.com>
CC: embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: emacs and X on embedded Linux
References: <F9102D41F595D311ACA7009027DE2C84967344@c3po.heurikon.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Johnson, Stephen B." wrote:

> I've only seen one version of embedded Linux the runs emacs & X on the PPC
> architecture. I used it on the Artesyn PM/PPC running a distribution from
> Protologos (www.protologos.com).  I know the guys at Protologos and they had
> to fix some things in the kernel to get it all working, but it only took a
> couple of hours to get everything working.
>
> In this case, everything can be done with a native PPC instead of the cross
> development involved with Monte Vista.
>
> Doesn't anybody else want this capability?
>
>

a lot of people develop boards running a bit slower than 450MHz..  hence
'embedded linux'.. sure if developing an extremely powerful custom board that
comfortably runs X, development tools, etc, it would probably be helpful, but
gets away from many peoples reasons for using embedded hardware (ie. low
ram/flash usage, small size, low cost cpu, etc)..

our custom board runs far slower than 450MHz, still, it runs X and
applications.. however, i would never bother compiling software on it, as i
have a G4 for that..

cheers,

ben


--
/\\------------------------------------------------------------------
ben.bodley/.m2technologyltd.nz/.benb@m2tech.co.nz/.64.9.4448307ext130


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
