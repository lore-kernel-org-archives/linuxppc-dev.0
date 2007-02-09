Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id E2345DDECE
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 09:37:51 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so821034ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 09 Feb 2007 14:37:45 -0800 (PST)
Message-ID: <528646bc0702091437n2d78124bj34d035e2a7a93ed3@mail.gmail.com>
Date: Fri, 9 Feb 2007 15:37:45 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: device tree / how to build/compile & use with u-boot to boot
	uImage?
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901066B2252@EMPBEDEX.empirix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <BD261180E6D35F4D9D32F3E44FD3D901066B2252@EMPBEDEX.empirix.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/9/07, Morrison, Tom <tmorrison@empirix.com> wrote:
> All,
>
> I tried to compile the default dts image (using the dtc compiler
> installed by LTIB), but it is complaining about no '/chosen' in
> the definition:
>
>   <path>/dtc -I dts -O dtb - -o mpc8548cds.dtb -V 16 dts/mpc8548cds.dts

Add the -f flag to ignore the warning.  It's bogus for what you're doing.

u-boot adds the chosen node at runtime.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
