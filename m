Message-ID: <383A982A.29E34C21@schweiz.ch>
Date: Tue, 23 Nov 1999 14:35:38 +0100
From: Andreas Tobler <a.tobler@schweiz.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Stephane GEORGES <sg@dalim.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: R_PPC_REL24 relocation out of range
References: <383A909A.16FCF296@dalim.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Stephane GEORGES wrote:
> 
> I am porting some code from linux Intel to linuxppc.
> 
> My executables have a plugin notion that allow people to add
> some new functionalities to program (like photoshop plugins).
> 
> My plugins are shared libraries whose name does not start
> with lib (like jobs.so.1.0).
> 
> These plugins can link on common shared libraries because
> they implement the same main classes.
> 
> My issue is that I get such an error message when the second
> plugin is beeing loaded (via dlopen)
> 
> jobs.so.1.0: R_PPC_REL24 relocation out of range (for instance)
> 
> If I rename my plugins adding lib in front of the name, then,
> it works correctly (libjobs.so.1.0).
> 
> Could someone help me so that it works without the lib added
> in front of the shared library name ?
> Does ld have special options so that it works ?
> (I have glibc-2.1.1-6c and my kernel is a 2.2.13).
> 
> The same code works correctly on my linux Intel (with same
> version of glibc).

Which version of binutils are you working with? Maybe a newer version
helps?
http://dev.linuxppc.org/pub/users/fsirl/R5/RPMS/ppc/binutils-2.9.5.0.14-0a.ppc.rpm

Andreas 
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail: andreas.tobler@alcatel.ch	| a.tobler@schweiz.ch
-----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
