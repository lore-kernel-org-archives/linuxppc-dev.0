Return-Path: <meador_inge@mentor.com>
Message-ID: <4D371EB4.3000703@mentor.com>
Date: Wed, 19 Jan 2011 11:26:12 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: Re: [PATCH] define binding for fsl mpic interrupt controllers
References: <1295306382-3246-1-git-send-email-stuart.yoder@freescale.com>
	<AANLkTim5i89k4OpUBWw0UgMoa5vwN5eSZ1MCs34S0VXB@mail.gmail.com>
	<4D34EB06.9040908@mentor.com>
	<9F6FE96B71CF29479FF1CDC8046E150306A71F@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E150306A71F@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Blanchard, Hollis" <Hollis_Blanchard@mentor.com>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/18/2011 01:47 PM, Yoder Stuart-B08248 wrote:
>
> I'm not sure a complete merge into one binding makes sense.  The thing that
> motivated creating this new binding with 4 cells was a thread from
> last year.  See:
>
> http://lists.ozlabs.org/pipermail/devicetree-discuss/2010-January/001489.html

I agree that one binding may not make sense, but perhaps we could have 
something like:

    dts-bindings/
    |-- mpic.txt
    |-- fsl
        |-- mpic.txt

where '.../fsl/mpic.txt' only documents the overrides (and maybe refers 
to '.../mpic.txt' in the intro).  For example, the 
'interrupt-controller', '#address-cells', and 'reg' properties are 
really not that different between the two bindings and could be placed 
just in '.../mpic.txt'.  Where as the specific interrupt specifier 
definition and the overrides for 'compatible' and '#interrupt-cells' 
could go in .../fsl/mpic.txt'.

> Since Freescale had the need to represent additional information
> in interrupt specifiers (error ints, timers, ipis), the suggestion
> at the end was to add additional cells in a FSL-specific binding.
> So this really is a Freescale specific thing and does belong in the
> Freescale binding directory.

Agreed.

> That being said, if there is consensus on the AMP related properties,
> I should probably incorporate those as well-- protected-sources
> and no-reset.
>
> I'll separately comment on your mpic binding patch.

Great, thanks.

-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
