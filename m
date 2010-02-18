Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1054B7E81
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 05:11:16 +1100 (EST)
In-Reply-To: <fa686aa41002180941y71201b27y64905fe34cc56deb@mail.gmail.com>
References: <2921453.1266505456809.JavaMail.ngmail@webmail09.arcor-online.net>
	<OFC412BED7.5D5934A3-ONC12576CE.005D5F44-C12576CE.005EBE55@transmode.se>
	<fa686aa41002180941y71201b27y64905fe34cc56deb@mail.gmail.com>
Subject: Re: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: Grant Likely <grant.likely@secretlab.ca>
Message-ID: <OFC6865529.46271A88-ONC12576CE.0063428C-C12576CE.006394F1@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 18 Feb 2010 19:07:41 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: glikely@secretlab.ca, iws@ovro.caltech.edu,
	=?ISO-8859-15?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	ben-linux@fluff.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

glikely@secretlab.ca wrote on 2010/02/18 18:41:40:
>
> On Thu, Feb 18, 2010 at 10:14 AM, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> > "Albrecht Dre=DF" <albrecht.dress@arcor.de> wrote on 2010/02/18 16:=
04:16:
> > As far as I can tell your patch does all of the above so
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
>
> Thanks Joakim.  On a point of process; "Signed-off-by" means that
> you've actually handled the patch and forwarded it on, either by
> reposting or putting it in a git tree for someone to pull.  The
> Signed-off-by trail collects a history of all the people who have
> touched a patch during its development and merging.
>
> Reviewers can use Acked-by: or Reviewed-by: to indicate their consent=
.
>  Ben can add your annotation when he merges the patch into his i2c
> tree.

I see, then please change that to
Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>


Thanks,
        Jocke=
