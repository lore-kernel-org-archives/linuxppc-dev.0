Date: Mon, 22 Feb 1999 09:38:47 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Paul.Mackerras@cs.anu.edu.au,
        Hartmut Koptein <koptein@et-inf.fho-emden.de>,
        zankel@tarantel.rz.fh-muenchen.de, bh40@calva.net,
        davidsen@prodigy.com, marsmail@globegate.utm.edu, dvdoug@tiac.net,
        paubert@iram.es, jskov@cygnus.co.uk, hozer@drgw.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [ppc-dev] Summary: Restructuring Efforts
In-Reply-To: <Pine.LNX.3.96.990219132018.12450A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.3.96.990222093231.1072A-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 19 Feb 1999, Cort Dougan wrote:

I was concerned that people might think that ALL embedded boards would
fall into the "embedded" bootloader and it could cause confusion down the
line.  I think most MTX systems out there are running 32MB+ usually.  I
can't answer for sure what most are using as a boot device, but it does
vary.  Usually it's going to be out of FLASH since it is intended and
priced for rugged embedded applications.  Since VxWorks runs on most MCG
boards in general, you can bet that it is quite common to boot out of
FLASH.
  
> The concern in this discussion (If I'm following along correctly) is RAM
> size, that's all.  The PReP bootloader works on MTX even though it's not
> in the embedded dir.  Since RAM is the issue how much RAM does a typical
> MTX installed system have?  Do they boot from flash or from a hd once
> deployed?
> 
> }PReP and CHRP machines are not necessarily desktops/servers.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
