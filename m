Date: Thu, 10 Aug 2000 11:50:04 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Topi Kanerva <tkanerva@ees2.oulu.fi>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Derek Homeier <supas100@astrophysik.uni-kiel.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Backlight control on Lombard PB
In-Reply-To: <Pine.GSO.4.21.0008100940040.28327-100000@stekt6>
Message-ID: <Pine.LNX.4.10.10008101149110.1740-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Should be fixed in BenH's current tree, he said he was going to do it this
> >past weekend. The pmu backlight controller didn't get registered on the
> >Lombard (and possibly Wallstreet) because the backlight-control property
> >is missing on these machines.
>
> Well, the backlight control surely doesn't work on Pismos... I just hate

I was speaking about Lombard and related machines. On the Pismo, the
backlight control is in the display driver IIRC.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
