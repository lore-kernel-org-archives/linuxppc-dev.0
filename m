To: linuxppc-dev@lists.linuxppc.org
Subject: Re: AltaVec support
References: <Pine.OSF.3.96.1000627161511.20198G-100000@torres.msoe.edu>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 28 Jun 2000 09:25:09 +0200
In-Reply-To: ian reinhart geiser's message of Tue, 27 Jun 2000 16:16:23 -0500 (CDT)
Message-ID: <8xk8fa4696.fsf@s62.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ian reinhart geiser <geiseri@msoe.edu> writes:

> How stable is the altavec gcc?
>
> I am looking at using it for a project but have some concernes
> about the stability of software built with it.
>
Several people over on the AltiVec mailing list run PowerPC Linux and
use the patched gcc for development. So far, the only compiler bugs
discussed there were found in Metrowerks' CodeWarrior. And since many
of the AltiVec hackers have the habit of looking at the compiler generated
code (they are speed freaks, after all :-), I think one can be quite
confident that there are no bugs in gcc-AltiVec that show up frequently
enough to be of concern.

  Holger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
