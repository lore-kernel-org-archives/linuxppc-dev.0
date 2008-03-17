Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 0ECAEDE1CC
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 06:39:03 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b2so1212524ana.81
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 12:39:02 -0700 (PDT)
Message-ID: <fa686aa40803171239h46878550r1b58d796d0ff8af6@mail.gmail.com>
Date: Mon, 17 Mar 2008 13:39:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Adrian Bunk" <bunk@kernel.org>
Subject: Re: powerpc: cuImage.* creation error
In-Reply-To: <20080317193652.GA9550@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080317193652.GA9550@cs181133002.pp.htv.fi>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 1:36 PM, Adrian Bunk <bunk@kernel.org> wrote:
> When building all powerpc defconfigs in 2.6.25-rc6 exactly three of
>  them fail to build, and all with similar problems:
>
>  powerpc64-linux-ld: arch/powerpc/boot/cuboot-tqm8540.o: No such file: No such file or directory
>  make[2]: *** No rule to make target `arch/powerpc/boot/cuImage.tqm8548', needed >  powerpc64-linux-ld: arch/powerpc/boot/cuboot-tqm8540.o: No such file: No such file or directory
>  make[2]: *** [arch/powerpc/boot/cuImage.tqm8540] Error 1
>
>  Is this a problem on my side or is there a bug that should be fixed?

I may have messed something up.  I'll dig into it this afternoon.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
