Date: Wed, 1 Dec 1999 11:43:47 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Jason Kim <jwk2@eecs.lehigh.edu>
cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Subject: Re: patch for problem with va-ppc.h included with egcs and   gcc-2.95.2
In-Reply-To: <384574A2.A003F5F6@eecs.lehigh.edu>
Message-ID: <Pine.LNX.3.96.991201114002.11654K-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 1 Dec 1999, Jason Kim wrote:

> Having a fixed size array as a user accessible item (which is TYPEDEF'ed to
> resemble a structure, no less) which could be passed around is just a BAD idea
> in C/C++. I have yet to hear any concrete reasons (besides just plain
> obstinacy) why va_list HAS to be implemented this way.

Years of legacy binaries that would have to be rebuilt, for one.  The fact
that we _just_ had a varargs-related rework of some programs (linux
kernel, mach kernel, etc. come to mind) for gcc 2.95.x is another reason. 
Mucking with the way the compiler builds varargs can have really nasty
implications.  It should not be changed for trivial reasons.  The macros
are there to be used.  Attempting to do anything else with varargs breaks
spec, and changing the compiler and everything ever built with it just to
make it easier for coders to be sloppy is a bad idea (tm).


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
