Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id BCD81DE0E5
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 23:07:59 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so129426anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 06:07:58 -0700 (PDT)
Message-ID: <fa686aa40804300607k72ef9985m43b3c4111cad6085@mail.gmail.com>
Date: Wed, 30 Apr 2008 07:07:58 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: joakim.tjernlund@transmode.se
Subject: Re: [PATCH] [POWERPC] mpc5200: Allow for fixed speed MII
	configurations
In-Reply-To: <1209540962.18445.8.camel@gentoo-jocke.transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080429230620.11248.25729.stgit@trillian.secretlab.ca>
	<1209540962.18445.8.camel@gentoo-jocke.transmode.se>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2008 at 1:36 AM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
>
>  On Tue, 2008-04-29 at 17:06 -0600, Grant Likely wrote:
>  > From: Grant Likely <grant.likely@secretlab.ca>
>  >
>  > Various improvements for configuring the MPC5200 MII link from the
>  > device tree:
>  > * Look for 'current-speed' property for fixed speed MII links
>
>  Not that I have looked, but why can't you use the fixed-link property?

fixed-link seems to be a recent invention, whereas current-speed is
better know having already been in use with serial devices.  It seemed
to me to be a better choice, but my opinion can probably be swayed
(arguments welcome).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
