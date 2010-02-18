Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f184.google.com (mail-yw0-f184.google.com
	[209.85.211.184]) by ozlabs.org (Postfix) with ESMTP id 14B36B7EC5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 04:42:01 +1100 (EST)
Received: by ywh14 with SMTP id 14so1333496ywh.15
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 09:42:00 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <OFC412BED7.5D5934A3-ONC12576CE.005D5F44-C12576CE.005EBE55@transmode.se>
References: <2921453.1266505456809.JavaMail.ngmail@webmail09.arcor-online.net>
	<OFC412BED7.5D5934A3-ONC12576CE.005D5F44-C12576CE.005EBE55@transmode.se>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 18 Feb 2010 10:41:40 -0700
Message-ID: <fa686aa41002180941y71201b27y64905fe34cc56deb@mail.gmail.com>
Subject: Re: [Patch v2 1/2] 5200/mpc: improve i2c bus error recovery
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org,
	=?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>,
	devicetree-discuss@lists.ozlabs.org, ben-linux@fluff.org,
	iws@ovro.caltech.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 18, 2010 at 10:14 AM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
> "Albrecht Dre=DF" <albrecht.dress@arcor.de> wrote on 2010/02/18 16:04:16:
> As far as I can tell your patch does all of the above so
>
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>

Thanks Joakim.  On a point of process; "Signed-off-by" means that
you've actually handled the patch and forwarded it on, either by
reposting or putting it in a git tree for someone to pull.  The
Signed-off-by trail collects a history of all the people who have
touched a patch during its development and merging.

Reviewers can use Acked-by: or Reviewed-by: to indicate their consent.
 Ben can add your annotation when he merges the patch into his i2c
tree.

Cheers,
g.
