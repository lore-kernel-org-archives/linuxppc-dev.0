Return-Path: <annamaya@yahoo.com>
Received: from web53807.mail.yahoo.com (web53807.mail.yahoo.com
	[206.190.36.202]) by ozlabs.org (Postfix) with SMTP id C49232BF07
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Nov 2004 04:30:23 +1100 (EST)
Message-ID: <20041109173021.80308.qmail@web53807.mail.yahoo.com>
Date: Tue, 9 Nov 2004 09:30:21 -0800 (PST)
From: annamaya <annamaya@yahoo.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <22B5F92B-3273-11D9-8E74-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8xx binaries running on a MPC82xx board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan,

I appreciate your reply. And I apologize for asking
you again if this was in the archives. BTW, are the
archives back up again somewhere, after the whole
linuxppc embedded mailing server crash?

You said that there were a lot of kernel level
differences that you mentioned about between the 8xx
and 82xx. Can you be more specific and give me some
examples? I will be mostly working with kernel space
code for the 82xx and I would like to understand the
differences here.

Thanks again.

--- Dan Malek <dan@embeddededge.com> wrote:

> 
> On Nov 9, 2004, at 11:37 AM, annamaya wrote:
> 
> > I was under the assumption that the MPC8xx core
> was
> > different from the MPC82xx core (the 603e?).
> 
> Yes, it is different, but the instructions are all
> the same.
> 
> > ...... But I was
> > surprised to find that the MPC8xx binaries were
> > running fine on a MPC82xx binaries, even if they
> were
> > dynamically linked and were linking to the MPC82xx
> > libraries. What's going on here?
> 
> Partly luck, and partly that the instructions are
> the same.
> The luck part is you aren't using floating point. 
> The 8xx
> doesn't have hardware floating point, but the 82xx
> generated
> code may have some instructions.  It also depends
> upon
> the tools you are using.  If you were using
> different glibc
> versions, your luck would have run out.
> 
>  From a user space application perspective, there
> are
> exactly two differences between 8xx and 82xx.  One
> is
> floating point and the other is cache line size. 
> The 8xx
> software will run fine on the 82xx, but 82xx may not
> work properly on 8xx.
> 
> > ...... Can I just use the
> > 8xx toolkit to work with the 82xx?
> 
> An 8xx toolkit will always work on 82xx, but
> depending
> upon the way it was built, you will not get the
> maximum
> performance of the 82xx.  Some tool vendors generate
> toolkits (and libraries) specifically for the 8xx,
> where the
> floating point is all emulated in software.  If you
> were looking
> for floating point performance, you would be very
> disappointed
> with this on the 82xx.
> 
> > ....... There must be SOME
> > differences between these two architectures. Can
> > someone here explain this to me?
> 
> There are lots of differences in the kernel
> programming
> model, but only the two I mentioned for user space
> applications.  In fact, across the entire PowerPC
> architecture
> you will only see floating point, Altivec, SPE, and
> some
> cache line operation/implementation differences at
> the user level.  Depending upon your software
> requirements and implementation, you are likely
> able to run many of the same binaries across all
> of the PowerPC cores.
> 
> I guess we are rewriting the archives now? :-)
> 
> 
> 	-- Dan
> 
> 



		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 
