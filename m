Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 50127DE03B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 11:59:32 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so102794anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 16:59:31 -0800 (PST)
Message-ID: <fa686aa40801091659i69c47fe3h533e8ca858059bb7@mail.gmail.com>
Date: Wed, 9 Jan 2008 17:59:30 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>, "Li Yang" <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH 1/3] add default device trees for MPC837x MDS board
In-Reply-To: <20080109234215.GA17153@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
	<fa686aa40801080758o35dce96ej5db45576769561a5@mail.gmail.com>
	<20080109234215.GA17153@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/9/08, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Tue, Jan 08, 2008 at 08:58:17AM -0700, Grant Likely wrote:
> > > +                       compatible = "mpc83xx_wdt";
> >
> > "fsl,mpc8377_wdt", "fsl,mpc83xx_wdt" as per generic names recommended practice.
>
> Uh.. that's reasonable advice, but it has nothing to do with the
> generic names recommended practice.

Actually, that *is* advice given in the generic names recommended
practice document:

http://www.openfirmware.org/1275/practice/gnames/gnamv14a.html#HDR11
Section 6.2, last sentence.

:-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
