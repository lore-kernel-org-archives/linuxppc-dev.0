In-Reply-To: <Pine.LNX.4.02.9901022154330.2266-100000@cassiopeia.home>
Date: Sun, 3 Jan 1999 10:42:28 +0100
To: linuxppc-dev@lists.linuxppc.org,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: __init, __openfirmware, etc...
Message-Id: <19990103104228.031876@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 2, 1999, Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be> wrote:

>__init sections are indeed removed after kernel initialisation. The
other ones
>are removed depending on the dynamic run type of the machine, e.g. __pmac
>sections are removed on PReP, and so on. Saves quite some valuable
unswappable
>kernel memory.c

Ok. Do you know what happens to static datas declared within an __init
function ? Is it removed to ? I have a function that use a static array
for putting permanent "override" values for part of the device tree and
this array must not be removed. Should I put the static array out of the
function too or will this remove mecanism avoid bss sections ?

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
