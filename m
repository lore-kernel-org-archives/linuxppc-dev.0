Date: Wed, 24 May 2000 09:11:27 +0200
Subject: Re: Debian pmud package available 
From: Stephan Leemburg <stephan@jvc.nl>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Sergio Brandano <sb@dcs.qmw.ac.uk>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>, <debian-powerpc@lists.debian.org>
Message-ID: <B5514D3F.E6B3%stephan@jvc.nl>
In-Reply-To: <Pine.LNX.4.10.10005232000150.28612-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


on 23-05-2000 20:09, Michael Schmitz at
schmitz@zirkon.biophys.uni-duesseldorf.de wrote:

>> Thank's a lot for making this package. Did you manage to contact
>> Stephan? What about the apmd patch?

Yes, thanks! If you wish I can pull it to my source-tree and also distribute
the debian package on every release...

>
> Just what I needed to get half way up to speed with Debian packaging again
> :-)
>
> I've not had an answer from Stephan but I didn't give him any heads-up
> either. The apmd patch seems to be included, it's enabled by the -a option
> to pmud as far as I could see. The fifo (/etc/power/apm) is created
> during installation, so all it should take is adding the -a to the
> PMUD_FLAGS definition in /etc/default/power. I need to document this :-)

Yes, it's activated with the -a flag (see pmud --help for details). I need
to modify the manuals and /etc/power/apm. You must have a modified apm
program to use it however, as the 'standard' apm programs all read from
/proc/apm and this path is usually compile time determined...

--
Stephan

>
>> On testing, I'm out of business for a while, as the baby is being
>> visited by the doctor (faulty display).
>
> Speedy recovery for the baby ...
>
> Michael
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
