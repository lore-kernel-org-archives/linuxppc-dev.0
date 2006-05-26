Return-Path: <malik_mca2000@yahoo.co.in>
Received: from web8413.mail.in.yahoo.com (web8413.mail.in.yahoo.com
	[202.43.219.101]) by ozlabs.org (Postfix) with SMTP id 6781B67A79
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 May 2006 00:00:42 +1000 (EST)
Message-ID: <20060526140039.63913.qmail@web8413.mail.in.yahoo.com>
Date: Fri, 26 May 2006 15:00:39 +0100 (BST)
From: sandeep malik <malik_mca2000@yahoo.co.in>
Subject: Re: Help Needed: floating point used in kernel (task=c0398410,
	pc=3184)
To: Roger Larsson <roger.larsson@norran.net>, linuxppc-embedded@ozlabs.org
In-Reply-To: <200605260949.48627.roger.larsson@norran.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Roger,

The kernel is not linked with uClibc/glibc its user
application only which is linked with uClibc/glibc....
What i am able to conclude is that the library
internall might be using floating point operations and
might be genrating some floating point instructions
which are not handled by our board....and that might
be the reason....or this error might be mapped in a
generic way such that it is getting flashed in some
particular scenarios.....
I might be wrong but as of now i don't have any other
explaination as now after linking with glibs the
application is working fine.....

Regards,
Malik

--- Roger Larsson <roger.larsson@norran.net> wrote:

> On fredag 26 maj 2006 09.38, you wrote:
> > Hi Roger,
> >
> >   The problem has been resolved...the issue was in
> the make
> > file.....actually we were cpmiling the code with
> gclibc and linking it with
> > uClibc which was causing the problem.....But this
> was real test i faced
> > till now as all the tricks realted to the message
> were failed.....any ways
> > thanks for ur help.... 
> >   Regards,
> >   Malik
> 
> Now I am confused!
> 
> How could this cause
> "floating point used in kernel (task=c0398410,
> pc=3184)"
> 
> Both uClibc and gclibc are user land libraries. They
> should not be able to
> cause an kernel floating point operation. No user
> land code should be able
> to do this!
> 
> Or is it your kernel linked with uClibc/gclibc? I do
> not think that is the
> right thing to do...
> 
> /RogerL
> 


Send instant messages to your online friends http://in.messenger.yahoo.com 
