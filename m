Message-ID: <3757E59D.B18BCA8C@phx.mcd.mot.com>
Date: Fri, 04 Jun 1999 07:41:33 -0700
From: Johnnie Peters <jpeters@phx.mcd.mot.com>
MIME-Version: 1.0
To: "linuxppc-dev-digest@lists.linuxppc.org"
 <linuxppc-dev-digest@lists.linuxppc.org>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Abukhdeir Nasser-ana007 <Nasser_Abukhdeir-ANA007@email.mot.com>
Subject: Re: Support for Motorola Platforms
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello Abukhdeir

Yes we are making new machines.  The systems I work on are all
PowerPC based and intended for the embedded systems market.  Here
is a list of the machines (these are engineering names for the most
part) this patch will allow LinuxPPC to boot on:

Older PCI based machines
    Comet
    Blackhark
    Utah

Newer PCI
    MTX
    MTX+

VME
    MVME1600
    MVME2300
    MVME2400
    MVME2600
    MVME2700
    MVME3600

Compact PCI
    Mesquite (CPX8216 main processor board)
    Sitka    (CPX8216 slave procesor board)

The dual processor MTX series and MVME4600 will boot but only run
on one processor.  Work is underway to get the second aprocessor
going.

Motorola has a new version of the MVME2400 with the MAX processor and
as soon as I can get my hands on one I will do the work to get Linux
to run on it.  Plans are also underway for new versions of the MTX
series
supporting the MAX processor.

I invite any inquires about our machines you might have.  And please
call
me Johnnie.  I'll never become accostimed to the Mr. Peters stuff.

Abukhdeir Nasser-ana007 wrote:
> 
> Mr .Peters:
>         Sorry for the ignorant question, but is Motorola still making new
> machines?  What Motorola platform are you talking about?  I apologize for
> the dumb questions...
> 
> 
> Nasser

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
