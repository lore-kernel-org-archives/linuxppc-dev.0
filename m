Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by ozlabs.org (Postfix) with ESMTP id CF116DE188
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 04:25:02 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so148132wxd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Apr 2008 10:25:01 -0700 (PDT)
Message-ID: <fa686aa40804041025i552c64e6j87fcb743e398ddf9@mail.gmail.com>
Date: Fri, 4 Apr 2008 11:25:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <1207329303.6518.16.camel@weaponx>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
	<fa686aa40803171643y7db21cadsc454a713ba6c4342@mail.gmail.com>
	<47E938A8.9000103@semihalf.com>
	<fa686aa40803251151p457a2295w449222654be4d0d1@mail.gmail.com>
	<47F22C9A.4050501@semihalf.com> <47F60D5D.5090402@semihalf.com>
	<fa686aa40804040911o63e2e3efg2d9a74fff082fb16@mail.gmail.com>
	<fa686aa40804040914s3f682e37r16b4cb299e2fc97e@mail.gmail.com>
	<20080404163858.GA25717@lixom.net> <1207329303.6518.16.camel@weaponx>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 4, 2008 at 11:15 AM, Josh Boyer >  > I really like the
idea. It would probably make sense to organize it in
>  > the same way as the platforms are done today, i.e. per processor/platform
>  > family. And then have shared/merged configs in the main config directory.
>
>  Yes.  I was thinking the same already for 4xx.  Essentially:
>
>  configs/ppc44x_defconfig
>  configs/ppc40x_defconfig
>  configs/44x/<board>_defconfig
>  configs/40x/<board>_defconfig

Sounds logical.  I'm cool with this.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
