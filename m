Subject: Re: iBook G3: status of 2.6.5
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Gioele Barabucci <dev@gioelebarabucci.com>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1080687801.13152.56.camel@gaston>
References: <c4c2si$dv7$1@sea.gmane.org>  <1080687801.13152.56.camel@gaston>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1080689835.9195.52.camel@thor.asgaard.local>
Mime-Version: 1.0
Date: Wed, 31 Mar 2004 01:37:16 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-03-31 at 01:03, Benjamin Herrenschmidt wrote:
>
> > Is there a working ALSA driver or I have to use the OSS one?
>
> I'm not sure how well the Alsa driver will work, it works pretty badly
> for me on the tipb 1Ghz, though the dmasound (oss) one works fine.

ALSA works better than dmasound on the same machine here... must be a
configuration issue on your end. :)


--
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
