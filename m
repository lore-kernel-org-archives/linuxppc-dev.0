Date: Fri, 19 Feb 1999 20:18:12 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
Cc: Matt Porter <mmporter@home.com>, Paul.Mackerras@cs.anu.edu.au,
        Hartmut Koptein <koptein@et-inf.fho-emden.de>,
        zankel@tarantel.rz.fh-muenchen.de, bh40@calva.net,
        davidsen@prodigy.com, marsmail@globegate.utm.edu, dvdoug@tiac.net,
        paubert@iram.es, jskov@cygnus.co.uk, hozer@drgw.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [ppc-dev] Summary: Restructuring Efforts
Message-ID: <19990219201812.A2814@wogglebug.cygnus.com>
References: <Pine.LNX.3.96.990219103803.23706C-100000@liberty.chnd1.az.home.com> <Pine.LNX.3.96.990219132018.12450A-100000@persephone.cs.nmt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.990219132018.12450A-100000@persephone.cs.nmt.edu>; from Cort Dougan on Fri, Feb 19, 1999 at 01:21:35PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 19, 1999 at 01:21:35PM -0700, Cort Dougan wrote:
> 
> The concern in this discussion (If I'm following along correctly) is RAM
> size, that's all.  The PReP bootloader works on MTX even though it's not
> in the embedded dir.  Since RAM is the issue how much RAM does a typical
> MTX installed system have?  Do they boot from flash or from a hd once
> deployed?

Note, on my little PowerStack with 48 meg of memory, the new bootloader does
not work (as I reported previously -- there are no messages after the prompt).
The old bootloader works on the machine, but not on my big Utah PowerStack with
128 meg of memory.

> }PReP and CHRP machines are not necessarily desktops/servers.

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
