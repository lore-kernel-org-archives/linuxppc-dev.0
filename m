Subject: Re: PREEMPT on PPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@debian.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <Pine.LNX.4.44.0403261442210.3900-100000@opal.biophys.uni-duesseldorf.de>
References: 
	 <Pine.LNX.4.44.0403261442210.3900-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1080329240.17435.293.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Fri, 26 Mar 2004 20:27:20 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-03-26 at 18:48, Michael Schmitz wrote:
>
> Works fine here on 2.6.5-rc2-ben0 . Including disk suspend.

Have you hit swap with it? The problems with preempt usually only
started at that point here.

--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
