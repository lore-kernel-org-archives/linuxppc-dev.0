Subject: Re: ibook G4 Status Report
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: cpistagna@vrlteam.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040222111847.GX2289@adapter.n0skillz.org>
References: <20040222111847.GX2289@adapter.n0skillz.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077644505.14639.94.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Tue, 24 Feb 2004 18:41:46 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-02-22 at 12:18, Costantino Pistagna wrote:
>
> Now the second screen switch in clone-mode without any problem. The only
> trouble is that the output resolution is the same of the embedded lcd,
> so the max res that i can use is 1024x768; no matter about the paramters
> specified in XF86Config.

You need to set up either multiple screens or clone modes to go beyond
that.

> If it's usefull, i've patched my OF to unlock the video resolutions as
> described in some howtos on the net.

Only Mac OS cares about that, in order to artificially cripple iBooks.


> if you've readed carefully above, i've to disable the second screen in
> ServerLayout; if i turn it on the system start with an 8bits ColorDepth.
> I've no idea about this...maybe i've done some mistake.

Impossible to tell without seeing the server log.


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
