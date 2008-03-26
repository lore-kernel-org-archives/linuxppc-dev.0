Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 5FB4EDE11B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 08:16:49 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so32071anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 14:16:47 -0700 (PDT)
Message-ID: <fa686aa40803261416s38164c98ua774731eadc1f85f@mail.gmail.com>
Date: Wed, 26 Mar 2008 15:16:47 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [RESEND][POWERPC] mpc5200: Amalgamated dts fixes and updates
In-Reply-To: <47EAB9CC.7060002@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
	<fa686aa40803201650t289cd800gfda389b192c1834c@mail.gmail.com>
	<47E2FC3E.1020705@semihalf.com>
	<fa686aa40803201720l3e42c983se121ebc257c89912@mail.gmail.com>
	<20080321235633.GB345@frozen.semihalf.com>
	<fa686aa40803212014ne560615sfcdef542d59eb6cb@mail.gmail.com>
	<20080326194526.GA17424@frozen.semihalf.com>
	<47EAB9CC.7060002@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 3:02 PM, Matt Sealey <matt@genesi-usa.com> wrote:
> Bartlomiej Sieka wrote:
>  > +
>  > +                     phy0:ethernet-phy@0 {
>  > +                             device_type = "ethernet-phy";@0"
>  > +                             reg = <0>;
>  > +                     };
>
>  What's the parsing of this pan out to? What does it mean?
>
>  Having colons in device names is totally contrary to OF device naming
>  spec. Does the part after the colon have a special meaning to the DTC?

"phy0:" is a label used by dtc.
"ethernet-phy@0" is the node name.

>
>  I also was under the impression that device_type was invalid in a DTS
>  file, have we changed our minds again?

No, we haven't.  It kind of sneaked back in for ethernet phys.  I
don't know why.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
