Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A5A3679E2
	for <linuxppc-dev@ozlabs.org>; Sat, 14 May 2005 05:30:59 +1000 (EST)
Date: Fri, 13 May 2005 21:30:49 +0200
From: Colin Leroy <colin@colino.net>
To: "Nghiem, Tien" <TNghiem@oerlikon.ca>
Message-ID: <20050513213049.222963d3@jack.colino.net>
In-Reply-To: <CCD52035B75A5D4E8A481EFB132C42EA28E5CF@mail.oerlikon.ca>
References: <CCD52035B75A5D4E8A481EFB132C42EA28E5CF@mail.oerlikon.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org,
	Garcia =?ISO-8859-15?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
Subject: Re: eth0: PHY id 0x00221619 is not supported! HELP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 13 May 2005 at 14h05, Nghiem, Tien wrote:

Hi, 

>          rc = reset_one_mii_phy(phy, mii_id);
>         //if (rc)
>         //        return -ENODEV;

Why disabling such guards?

>         //for (i=0; (def = mii_phy_table[i]) != NULL; i++)
>         //        if ((id & def->phy_id_mask) == def->phy_id)
>         //                break;

Just an idea, I guess it'd be far more clean to add the phy id to
mii_phy_table[] (and, optionally, send the patch so you won't have to
do it everytime).

You're just asking for breakage there.
-- 
Colin
