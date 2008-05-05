Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.241])
	by ozlabs.org (Postfix) with ESMTP id 6A7DADDE1F
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 05:38:32 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so686980agc.0
	for <linuxppc-dev@ozlabs.org>; Mon, 05 May 2008 12:38:30 -0700 (PDT)
Message-ID: <fa686aa40805051238n7df0c24fmc9fabeef4b7f6c63@mail.gmail.com>
Date: Mon, 5 May 2008 13:38:30 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [PATCH] add Phytec pcm030 board support
In-Reply-To: <1328d38bed8a830af756850bbaf2e8ad@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080425134805.GP6692@pengutronix.de>
	<20080505011607.GA9349@yookeroo.seuss>
	<1328d38bed8a830af756850bbaf2e8ad@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 5, 2008 at 12:06 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> >
> > > Add board support for the Phytec pcm030 mpc5200b based board. It
> > > does not need any platform specific fixups and as such is handled
> > > as a mpc5200 simple platform.
> > >
> >
> > Those still whingeing about how horrible and hard and tedious the new
> > world of device trees is, take note.  We've certainly had some
> > teething problems as we all figure out how to use the device tree
> > properly.  But this is the payoff: support for a new board added with
> > one text file.  It's only going to get more common.
> >
>
>  /me imagines a world where every sane device (not just PowerPC)
>  uses OF device trees...

PowerPC? check.
Sparc? check.
Microblaze? check.

its just a matter of taking them out one at a time.  :-P

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
