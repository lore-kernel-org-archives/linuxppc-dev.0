Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id 8E4DAB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 18:03:53 +1100 (EST)
Received: by ywh39 with SMTP id 39so2045561ywh.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 Nov 2009 23:03:51 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200911120733.58112.roman.fietze@telemotive.de>
References: <mailman.1198.1256674402.12812.linuxppc-dev@lists.ozlabs.org>
	<200910281420.n9SEKI2R005094@nti1.com>
	<200911120733.58112.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Nov 2009 00:03:31 -0700
Message-ID: <fa686aa40911112303k1528a3c9yef3573454c75a2a4@mail.gmail.com>
Subject: Re: Micrel PHY KSZ8001 on MPC5200B FEC
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 11, 2009 at 11:33 PM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> As Grant mentioned as well, the key was and is a correct DTS. (At
> least) one statement was missing:
>
> =A0interrupt-parent =3D <&mpc5200_pic>;
>
> This statement seemed to move all the way up from the devices to the
> root of the tree, and somehow we missed that move.

Yes, nodes inherit the interrupt-parent property from their parent.  I
took advantage of that to tidy up all the mpc5200 device trees.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
