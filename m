Date: Tue, 23 Nov 1999 15:47:55 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: toa@pop.agri.ch
cc: Stephane GEORGES <sg@dalim.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: R_PPC_REL24 relocation out of range
In-Reply-To: <383A982A.29E34C21@schweiz.ch>
Message-ID: <Pine.LNX.4.10.9911231546300.21436-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > My issue is that I get such an error message when the second
> > plugin is beeing loaded (via dlopen)
> > 
> > jobs.so.1.0: R_PPC_REL24 relocation out of range (for instance)

'undefined external reference' in PPCese. 

> Which version of binutils are you working with? Maybe a newer version
> helps?
> http://dev.linuxppc.org/pub/users/fsirl/R5/RPMS/ppc/binutils-2.9.5.0.14-0a.ppc.rpm

Rather a new version of ld.so (or the proper LD_PRELOD magic). 

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
