Subject: Re: MPC85xx support
From: Jon Loeliger <jdl@motorola.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Gerrit Van de Velde <gvd@denayer.wenk.be>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <407EA4CA.4080208@embeddededge.com>
References: <407E5F36.80003@denayer.wenk.be>
	<1082036134.20892.8.camel@baz.sps.mot.com>
	<407EA4CA.4080208@embeddededge.com>
Content-Type: text/plain
Date: 15 Apr 2004 10:29:59 -0500
Message-Id: <1082043000.20893.34.camel@baz.sps.mot.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-04-15 at 10:05, Dan Malek wrote:
> Jon Loeliger wrote:
>
> > I am planning to release an updated version of the mpc85xx support
> > for U-Boot in just a few days.  It will be updated to Rev 1.1 and
> > has major improvements to the TSEC driver.
>
> Major improvements?  I recently posted a patch for the RPC/STx 8560
> board that included some TSEC updates, I don't know if they have made
> it into the CVS.  If not, please snag that from the mailing list so
> they are not lost.

Yesterday and today I have sync'ed up our internal tree to include
the delta up to the U-Boot 1.1.0 release.  Relative to what we had
in our tree before that (circa 2004_01_26), the only changes to the
TSEC code were a bunch of volatile declaration changes.  Those mods
are effectively captured in our update.  If there was more than that,
since the 1.1.0 release, I'll go searching...


> 	-- Dan

jdl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
