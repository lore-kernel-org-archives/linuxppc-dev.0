Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id A3C4EDDECA
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 02:46:50 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1808817ugf
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 07:46:48 -0800 (PST)
Message-ID: <528646bc0612190746g6a38f5d6kf73160a5814b57fb@mail.gmail.com>
Date: Tue, 19 Dec 2006 08:46:48 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
In-Reply-To: <1166538553.25827.99.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166522096.25827.76.camel@pmac.infradead.org>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
	<1166538553.25827.99.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	bbrv@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/19/06, David Woodhouse <dwmw2@infradead.org> wrote:
> On Tue, 2006-12-19 at 12:55 +0100, Sylvain Munaut wrote:
> > Benjamin Herrenschmidt wrote:
> > > Hrm... I told them to remove that from their device-tree ... dammit !
> >
> > Yes, I told them to do some other changes to their device-tree, but no
> > luck so far.
>
> OK, let's drop the patch and assume the device-tree will be fixed
> shortly. In the meantime, users should be able to work around it by
> hacking the device-tree from the OF prompt -- which we currently have to
> do for other things in the Efika device-tree anyway.

This will do for the time being; but I'm not expecting any changes to
be made to the firmware  (however, Sven is making the attempt).  In
the long term, I think we are going to have to live with either OF
fixups; or preventing CHRP from matching the efika and adding other
fixups in the Efika's probe function.  I like Sylvain's suggestion of
moving CHRP and pseries down in the link order; but then again, I'm
neither a CHRP or pseries user.  :)

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
