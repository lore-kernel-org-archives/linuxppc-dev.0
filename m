Date: Mon, 25 Oct 1999 17:44:35 -0500
From: erik cameron <cameron@senta.uchicago.edu>
To: Jim Terman <terman@ddi.com>
Cc: Claude Robitaille <crobitaille@videotron.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: question about altivec registers
Message-ID: <19991025174435.D9975@senta.uchicago.edu>
References: <199910252051.NAA07105@sade.ddi.com> <Pine.LNX.4.10.9910251826440.434-100000@localhost.localdomain> <199910252231.PAA08775@sade.ddi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199910252231.PAA08775@sade.ddi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



perhaps this is a stupid question, but aren't the values of the altivec
registers just saved as part of the process' hardware context and swapped
in and out as part of a context switch?  in which case it wouldn't matter
if the kernel (or any other process) changed the values while your job
was on a sleeping.

On Mon, Oct 25, 1999 at 03:31:48PM -0700, Jim Terman wrote:
> 
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
> > > kernal support, but can I be confident that the kernal will not touch
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

-- 
erik cameron  unix systems administrator
jfi/mrsec @ the university of chicago
e-cameron@uchicago.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
