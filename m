Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.246])
	by ozlabs.org (Postfix) with ESMTP id 08CD6DE04D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 03:26:27 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so221106agc.0
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Jan 2008 08:26:26 -0800 (PST)
Message-ID: <fa686aa40801090826h1c77b4f2y37d5d6468d7171@mail.gmail.com>
Date: Wed, 9 Jan 2008 09:26:25 -0700
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
>
> This should go into the kernel because its appearently
> impossible to boot the script via tftp and then load the real boot
> binary (yaboot or zimage).
>

Signed-off-by?

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
