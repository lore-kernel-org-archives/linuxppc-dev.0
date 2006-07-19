Return-Path: <linuxppcleo@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 355EA67B72
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 04:59:49 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so468096ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 11:59:44 -0700 (PDT)
Message-ID: <a0bc9bf80607191159l679ce8ddm35a30236a9d887c7@mail.gmail.com>
Date: Thu, 20 Jul 2006 02:59:44 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Dan Malek" <dan@embeddedalley.com>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
In-Reply-To: <1E6652B1-3126-4B69-BE9D-8DCE8DCACE7C@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <4879B0C6C249214CBE7AB04453F84E4D050B55@zch01exm20.fsl.freescale.net>
	<4856A73A-BB23-4850-A697-1CE7C385DE42@kernel.crashing.org>
	<1E6652B1-3126-4B69-BE9D-8DCE8DCACE7C@embeddedalley.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/19/06, Dan Malek <dan@embeddedalley.com> wrote:
>
> On Jul 19, 2006, at 9:14 AM, Kumar Gala wrote:
>
> > This is an incorrect assumption.  Its more often that people dont
> > post their ports to the Linux kernel for acceptance.  We will
> > accept any port that is willing to work with the community.   for
> > example
>
> I agree.  The customers of board ports I've done over the years
> are always eager to get these into the public sources.  It just
> seems we run out of time during the pressure of trying to get
> the products done, and they just issue them on CDs or for
> download afterward.

But why?  Most embedded products facing end-user wouldn't like users
to modify the system by themselves.  Sometimes they even put effort in
preventing user to do so.  If no one else is going to modify the code,
what is the value of putting them in public sources?  Just to show the
compliance with GPL?  The only kind of products I can think of, which
want the users to modify the code is reference boards, IMHO.  Please
correct me if I'm wrong.
