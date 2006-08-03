Return-Path: <linuxppcleo@gmail.com>
Received: from wx-out-0102.google.com (wx-out-0102.google.com [66.249.82.197])
	by ozlabs.org (Postfix) with ESMTP id 7312967A2E
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 01:47:11 +1000 (EST)
Received: by wx-out-0102.google.com with SMTP id t14so1039068wxc
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Aug 2006 08:47:09 -0700 (PDT)
Message-ID: <a0bc9bf80608030847w2a3fdbcek7825ad8a04f354ce@mail.gmail.com>
Date: Thu, 3 Aug 2006 23:47:08 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Tom Rini" <trini@kernel.crashing.org>
Subject: Re: RFC: Location for Device Tree Sources?
In-Reply-To: <20060802163822.GK3075@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
	<33AC4A3A-876A-4AF9-B851-928EE80A9D80@kernel.crashing.org>
	<20060802163822.GK3075@smtp.west.cox.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/3/06, Tom Rini <trini@kernel.crashing.org> wrote:
> On Wed, Aug 02, 2006 at 08:35:55AM -0500, Kumar Gala wrote:
>
> > I like this location and agree that having them in tree makes sense.
> > And putting them under boot isolates them from the kernel proper.
> >
> > The reason I see to having them in tree is to ensure proper version
> > compatibility.  This way there is no concern about which .dts version
> > will work with which kernel.  In the future we can always pull them
> > out when things are more stable.
>
> I'd rephrase that as an arguement to keep them out of tree:
>
> The reason I see to having them out of tree is to ensure we follow the
> intent trees holding the information about where devices live and the
> kernel being good and asking the trees.  This way there is no concern
> about which (otherwise valid) .dts version will work with which kernel,
> as breaking a valid .dts is either a bug (unintentional API change or a
> 'Oops, I forgot that the tree might not specify X' which potentially
> preempts the custom board Y (that's like a sandpoint!) just doesn't have
> X bugs) or a change that requires a dts version bump.
>
> I'll throw in the caveat that I'm not 100% sure we're that stable yet,
> but it certainly seems like it, at least for the overall portion where
> you might really have incompatible trees.  More or less complete (now
> every device is described!) dts should be interchangable to the kernel
> for the custom board X is just a little different from ref board Y
> issues (and now, in theory, the Just Like A Sandpoint board, with a
> correct dts will boot the 'sandpoint' kernel).

I don't know why we are talking about versions here.  My argument to
including dts in tree is very simple.  dts is in many ways similiar to
kernel config file.  If we justified to put default kernel config
files in tree.  There will be no difference to make dts in tree too.
Moreover, dts can't be generated or modified easily like kernel
config.  It's even more important to make a working example handier to
get for user.
