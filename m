Date: Thu, 13 May 2004 11:12:41 +0200 (CEST)
From: Marius Groeger <mgroeger@sysgo.com>
To: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Question on the fs choice
In-Reply-To: <EFB813091B18D511BD3600508B644F820A617EC3@tx14exm06.ftw.mot.com>
Message-ID: <Pine.LNX.4.56.0405131107030.2355@mag.sysgo.com>
References: <EFB813091B18D511BD3600508B644F820A617EC3@tx14exm06.ftw.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Adam,

Thanks for the interesting report.

On Wed, 12 May 2004, Zajac Adam-AAZ004 wrote:

> Coming back to the CF card discussion subject, does anybody know how the
> "power failure" scenario is resolved at such commercial platforms as pocket
> pc's and digital cameras utilizing CF cards?

Usually such devices have some power monitoring which indicates power
failure long before the worst case scenarios you described actually occur. I
could imagine the manufacturers just live with that.

Provided you can spare a CF card, you could take any such device and
manually induce a power failure while there is a write operation in
progress.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.com>           Project Manager
SYSGO AG                      Embedded and Real-Time Software
Voice: +49 6136 9948 0                  FAX: +49 6136 9948 10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
