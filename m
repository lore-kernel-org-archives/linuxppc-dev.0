From: Matevz Langus <matevy@arhitektova-delavnica.com>
Message-ID: <49705.193.77.24.1.1082042532.squirrel@www.arhitektova-delavnica.com>
In-Reply-To: <407EA4CA.4080208@embeddededge.com>
References: <407E5F36.80003@denayer.wenk.be>
    <1082036134.20892.8.camel@baz.sps.mot.com>
    <407EA4CA.4080208@embeddededge.com>
Date: Thu, 15 Apr 2004 17:22:12 +0200 (CEST)
Subject: Re: MPC85xx support
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Jon Loeliger" <jdl@motorola.com>,
	"Gerrit Van de Velde" <gvd@denayer.wenk.be>,
	"linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I also use U-Boot and Linux 2.4 on 8560 quite successfully.
Has anyone tried to use SPE unit of e500?

I would also be interested in dev versions of 85xx kernels? Is it possible
to get access to the cvs?

thanks,
  Matevz

>
> Jon Loeliger wrote:
>
>> I am planning to release an updated version of the mpc85xx support
>> for U-Boot in just a few days.  It will be updated to Rev 1.1 and
>> has major improvements to the TSEC driver.
>
> Major improvements?  I recently posted a patch for the RPC/STx 8560
> board that included some TSEC updates, I don't know if they have made
> it into the CVS.  If not, please snag that from the mailing list so
> they are not lost.
>
>> .....  An updated Linux release
>> is close as well, but I'll let my partner in crime speak there. :-)
>
> Those of us working on 85xx support have our own local versions of
> Linux 2.4.  Due to the amount of change and the desire to keep 2.4
> stable, we are negotiating some clever ways to get this checked into
> the public trees.  I have the U-boot and kernel available for the
> RPC/STx GP3 boards on my server, if that is useful to get you started.
>
> Thanks.
>
>
> 	-- Dan
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
