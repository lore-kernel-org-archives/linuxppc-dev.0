Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 9A709DDF7B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 02:10:53 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so59107anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 07:10:52 -0800 (PST)
Message-ID: <fa686aa40801090710x4d7a2997i3ae11b1d0992ea99@mail.gmail.com>
Date: Wed, 9 Jan 2008 08:10:51 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olaf Hering" <olaf@aepfle.de>
Subject: Re: add phy-handle property for fec_mpc52xx
In-Reply-To: <20080109140608.GA15673@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080109140608.GA15673@aepfle.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/9/08, Olaf Hering <olaf@aepfle.de> wrote:
>
> The new network driver fec_mpc52xx will not work on efika because the
> firmware does not provide all required properties.
> http://www.powerdeveloper.org/asset/by-id/46 has a Forth script to
> create more properties. But only the phy stuff is required to get a
> working network.

Question: What will happen with this code if the mdio and phy nodes
have already been created by the forth script?  There is not checking
to see if the phy node already exists.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
