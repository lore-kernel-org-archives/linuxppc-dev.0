From: dank@kegel.com
Message-ID: <3D39E178.2B75266B@kegel.com>
Date: Sat, 20 Jul 2002 15:17:28 -0700
Reply-To: dank@kegel.com
MIME-Version: 1.0
To: Philip Decker <pdecker@wavewireless.com>
Cc: vandana mehtani <vandana_mehtani123@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELF reader
References: <0E97488D670BD411B8BD00C0F03BDF6401799ECC@SPEEDCOM3>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oh, ok.  Perhaps VM can get support from WindRiver, then,
once he's verified that the ELF file in question is valid.

VM, have you a real PPC environment to run in, or
is the emulator your only one?

- Dan

Philip Decker wrote:
> I would assume VM refers to WindRiver's SingleStep simulator:
> http://www.windriver.com/products/html/ss_sim.html
>
> > -----Original Message-----
> > From: dank@kegel.com [mailto:dank@kegel.com]
> >
> > vandana mehtani wrote:
> > > i have made the crosscompiler for powerpc...
> > > i have a compiled a normal c program printf "hello world"
> > > with the cross compiler..
> > > when i try to download it to single step powerpc simulator..
> > > i get the following error
> > > "aborting due to failure of ELF reader"
> > > what cld be possible cause of error..
> >
> > Which emulator?  Are you using the one built into gdb?
> > Or some proprietary one?
> > - Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
