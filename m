Date: Mon, 25 Oct 1999 19:28:25 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: question about altivec registers
In-reply-to: <199910252231.PAA08775@sade.ddi.com>
To: Jim Terman <terman@ddi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9910251916060.5902-100000@modemcable220.93-200-24.mtl.mc.videotron.net>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The flag is to actually tell the kernel that your application is using
the Altivec registers, so that it can save time by not saving and
restoring them when the interrupted or swapped application is not using
them. It is supposed to be dynamic so only routines actually using Altivec
should set (and clear) it. I am not sure of the details so look into the
manual for the hardware support. I think the kernel should enforce the
use of this flag since moving the full Altivec register set is time
consuming (16 bytes X 32 registers = 1/2 KB).

Claude

On Mon, 25 Oct 1999, Jim Terman wrote:

> I understand how to get it working from the processor point of view.  I 
> just want to make sure that the linuxppc kernal will not interfere if I 
> compile a program that uses these registers.
> 
> The bottom line is that I am not looking for any help with the altivec
> registers from the kernal.  I just want to be sure that there will not
> be any inteference.  If not, great.  I'd just like that insurance.
> Thanks for any clarification you can give me.
> 
> Claude Robitaille writes:
> > There is a flag for that purpose. You should look into the Altivec
> > environment on Motorola's Web site, or at www.altivec.org
> > 
> > Claude
> > 
> > 
> > On Mon, 25 Oct 1999, Jim Terman wrote:
> > 
> > > 
> > > I have a question about using the altivec registers on a G4 Macintosh
> > > running linuxppc.  Will there be any conflicts.  I don't expect any
l
> > > kernal support, but can I be confident that the kernal will not
touch
> > > any of the altivec registers.  Any info will be greatly appreciated.
> > > 
> > > -- 
> > > ______________________________________________________________________________
> > > Jim Terman       |   323 Vintage Park Dr.   |   Voice: (650) 356-5446
> > > terman@ddi.com   |   Foster City, CA        |   Fax:   (650) 356-5490
> > > Diab-SDS, Inc.   |   94404                  |   web site - http://www.ddi.com
> > > 
> > > 
> > 
> > 
> -- 
> ______________________________________________________________________________
> Jim Terman       |   323 Vintage Park Dr.   |   Voice: (650) 356-5446
> terman@ddi.com   |   Foster City, CA        |   Fax:   (650) 356-5490
> Diab-SDS, Inc.   |   94404                  |   web site - http://www.ddi.com
> 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
