Subject: Re: IRQS on 6 Slot Macs
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Robert E Brose II <bob@kunk.qbjnet.com>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20031103033529.24416.qmail@kunk.qbjnet.com>
References: <20031103033529.24416.qmail@kunk.qbjnet.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1067859023.1653.15.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Mon, 03 Nov 2003 12:30:24 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-11-03 at 04:35, Robert E Brose II wrote:
> In trying to get OpenGL working on a YDL 3.0 system with kernel 2.4.22-ben2
> and XFree86-4.3.0-2.1e,  I get a warning on X initialization:
>
> (II) R128(0): [drm] failure adding irq handler, there is a device already using
> that irq

Not sure what's up with that (depending on how old the DRM is, the error
could be misleading though), but this shouldn't prevent the DRI from
working.


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Software libre enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
