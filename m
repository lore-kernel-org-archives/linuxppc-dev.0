In-Reply-To: <19990917161450.229.qmail@nwcst268.netaddress.usa.net>
Date: Fri, 17 Sep 1999 18:24:51 +0200
To: jeramy b smith <ultrapenguin@netscape.net>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Boot Methods Debate
Message-Id: <19990917182451.009307@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 17, 1999, jeramy b smith <ultrapenguin@netscape.net> wrote:

>My two-cents, go with the best available option for each architecture
and have
>the OS installer set up booting appropriately. Here is an example for a OF
>PowerMac using a RedHat style installer.
>
>->Load RedHat Installer (Yellow, LPPC, Turbo, etc)
>->Installer detects/asks what machine Im using (I select Beige DT G3)
>->Installer sets up my partitions and saves data to vars
>->Installer sets up video and saves data to vars
>->Installer asks what my default OS should be (I select Linux)
>->Installer applies all OF patches necessary and uses partition/video vars to
>set up boot options
>->reboot into linux

This is a possible installer scenario, but I'll leave it to people more
experienced with Linux userland than I am. First, let's make the CD
bootable ;-)

>I believe this is achievable since all the OF patches are "open" as ben
>pointed out. Of course, if I select a compatible Nubus Mac, the installer
>would set up miBoot. 

We also need to bundle some kind of MacOS INIT which will make sure to
put back those patches in nvram since MacOS loves removing them. Maybe
this could be done from a chained MacOS disk driver too (the driver would
detect the patch absence, put the back and then reboot).

>Of course, if I was a distributor, I would just go with whatever worked most
>reliably and consistently; programming paradigms and boot theories aside.
>


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
