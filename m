Return-Path: <Tom.Ziomek@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 8ECB46891D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 07:14:03 +1100 (EST)
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.12.11/Motgate7) with ESMTP id k0HKSBDs021363
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jan 2006 13:28:11 -0700 (MST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id k0HKRSXl004142
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jan 2006 14:27:28 -0600 (CST)
Date: Tue, 17 Jan 2006 14:12:28 -0600 (Central Standard Time)
From: T Ziomek <ctz001@email.mot.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
In-Reply-To: <mailman.134.1137523561.17753.linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.WNT.4.61.0601171341520.2664@holyoke.labs.mot.com>
References: <mailman.134.1137523561.17753.linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: tomz <CTZ001@email.mot.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here's another lurker poking his head up...

Grant Likely wrote:
> 
> John Bonesio wrote:
> > Hello,
> >
> > I work in the Xilinx software group.
> >
> > I'm replying to this email thread because Grant suggested there be a GIT
> > tree for Virtex specific changes.
> 
> I was told today that we may be able to use Paul's linuxppc tree.  I'm
> going to ask him later today.

Probably a newbie question...my understanding is that kernel.org is the
preferred repository for PPC-specific code these days, correct?  So the a-
bove is referring to Xilinx-specific PPC code?  From what I can see on LXR
and kernel.org neither has any Xilinx-related code...

> > I am wondering if the open source community would prefer or see a
> > benefit to Xilinx owning/hosting the source trees (CVS or GIT or
> > whatever) for our drivers, and in particular the Linux adapter drivers.
> > If we did this we would provide a web site with the information along
> > with instructions on how to submit changes.
> >
> > We are exploring this idea and wanted to know what others thought of
> > this.
> 
> Let's just keep things on the mailing list; it's the natural place to
> discuss issues.  If the traffic gets too high, we can do something
> different.

Re keeping discussion on linuxppc-embedded, sure.  Re the hosting of source
trees, I'd definitely like to see Xilinx take that on if the stuff dis-
cussed above doesn't come to pass.  We need to have a relatively stable,
long-term primary source for such code.

Tom Ziomek
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
