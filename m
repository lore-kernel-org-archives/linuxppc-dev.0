Message-ID: <20020313062922.21460.qmail@web12803.mail.yahoo.com>
Date: Tue, 12 Mar 2002 22:29:22 -0800 (PST)
From: satya kumar <i_satya@yahoo.com>
Subject: RE: EST's MPC8XX (Modular Development Platform) - Linux
To: Kiran Mandava <kiran.mandava@skystream.com>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A03457620@SERVER1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
  Thanks Kiran for helping me out...I shall be
starting with it as soon as possible.
  Another thing I wanted to know from you all PPC
masters out there, is wether the OCDemon BDM/JTAG
device supported by linux.If not... Is there a way
out.Please suggest me b'cos I have this device only
for any sort of BDM activity.
  I am using EST's(Now known as Vxworks)MPC860 board(
Modular Development Platform) for porting Linux to it.
 Anyone who has done this before using the same
board??Please guys help me out, I have not been
getting the answers to my queries regarding this
board.I am stuck.
Thanks and Regards,
Satya
--- Kiran Mandava <kiran.mandava@skystream.com> wrote:
> 1. compile the powerpc code on one of the machine
> with all the required
> options
>   to do this you need to change the make file in the
> main ppcboot
> directory..run the makefile. after compiling it
> generates a file called
> ppcboot.bin .
> 2. run a tftp server on this machine
> 3. copy the ppcboot.bin file to the tftproot
> directory
> 4. BDI boots using a tftp client and it needs couple
> of files line (*.cnf
> and regxxx.def) this is going to hold the processor
> in reset and then it
> sets the configuration of the 8xx.  BDI is connected
> to the board using the
> JTAG and to the external world using a ethernet
> port.
>  BTW don't you have the BDI manual. i guess it is
> explained very well in
> that manual.!
> 5. it supports command like erase prog and
> etc...!use these commands to
> erase the FALSH on the board and program it with the
> PPCBOOT.bin and then
> reset the board..! make sure it jumps to the
> ppcboot.bin after resetby
> copying the ppcboot.bin to the proper memory space.!
>
> kiran
>
>
> -----Original Message-----
> From: satya kumar
> To: Kiran Mandava
> Sent: 3/12/02 1:47 AM
> Subject: RE: EST's MPC8XX (Modular Development
> Platform) - Linux
>
> Hi Kiran ,
>   Thanks buddy for responding so quickly, Yaa I do
> have a Jtag port on the Board and I have a OCDemon
> BDI/JTAG device. But I have no information as to how
> to use BDI.THough I have certain cross-compiled gdb
> stuff for pcc.Do you ahve any information on How to
> use BDI.
>    PLease any help wud of much importance.I am
> stuck.
> Thanks and regards,
> Satya
> --- Kiran Mandava <kiran.mandava@skystream.com>
> wrote:
> >
> >
> > >-----Original Message-----
> > >From: satya kumar [ mailto:i_satya@yahoo.com
> > <mailto:i_satya@yahoo.com> ]
> > >Sent: Sunday, March 10, 2002 9:12 PM
> > >To: linuxppc-embedded@lists.linuxppc.org
> > >Subject: EST's MPC8XX (Modular Development
> > Platform) - Linux
> > >
> > >
> > >
> > >Hi All,
> > >    Any idea as to wether the MPC860 board
> provided
> > by
> > >the ESTC(which they call as Modular Development
> > >Platform) is suitable for a Linux Port.Since the
> > board
> > >that i have already has some VxWorks related
> stuff
> > in
> > >the begining.How to erase that and How to
> download
> > >ppcboot into to the Board?
> >
> > Do you have on board FLASH.
> > so do you have a way to access this flash ..! if
> you
> > have a JTAG port
> > connected try to use the BDI and program the ROM
> > with the PPCBOOT ..(make
> > sure you try to copy the PPCBOOT to the proper
> > location where the 8xx jumps
> > after reset..)
> > ..make sure that it goes through the PPCBOOT..!
> > compile the linux and use
> > the TFTPBOOT option first.(i know you could use
> lot
> > more options but this is
> > the simplest way to boot your box)
> >
> > >    Another thing I have compiled the kernel
> aiming
> > >this board and have selected the machine type as
> > MBX
> > >while configuring the kernel and chosen the
> > processor
> > >as 8xx.Is it Ok?
> > >    Please bear with me as I am only a newbie and
> > not
> > >a master.
> > >   Any help wud be much appreciated and Sorry
> again
> > >for disturbing you all.Thanks in advance.
> > >  Regards,
> > >  Satya
> > >
> > >
> > <http://lists.linuxppc.org/>
> > >
> >
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
