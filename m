Date: Wed, 20 Oct 1999 10:40:30 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: "David N. Welton" <davidw@linuxcare.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel questions
In-Reply-To: <19991018121353.D17058@bassano.linuxcare.com>
Message-ID: <Pine.HPX.4.10.9910201032360.16476-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 18 Oct 1999, David N. Welton wrote:

> There are a few options:
> 
> PowerMac
> Prep/MTX
> CHRP
> PowerMac/PReP/CHRP
> Gemini
> APUS

Actually I had the impression that the first three should disappear and
you should use the common PMAC/PreP/CHRP for these machines. I'm using
MVME boards (closer to MTX) with this option and a few patches since it
boots in PreP moe and I remap it to CHRP for VME addressing capability
reasons.


> 
> I'm compiling as CHRP, and since ADB is selectable as an option, it
> seems it could be added in anyway, pmac or not?

I don't think that I have ADB compiled in (I'll check again). The only
problem is that I'm looking for a clock program which assumes that you are
on a PowerMac.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
