Return-Path: <diggskevin38@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED304B6F53
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Jul 2011 04:23:07 +1000 (EST)
Received: by vws20 with SMTP id 20so2018920vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 11:23:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTimjBfMBXEdH7k-6sTjb1P+Fq3-Fvg@mail.gmail.com>
References: <1308316207-9075-1-git-send-email-dbaryshkov@gmail.com>
	<1308316207-9075-2-git-send-email-dbaryshkov@gmail.com>
	<1309318110.32158.520.camel@pasglop>
	<BANLkTikD_x3QA8_q8+444QhA39SEW6hVfg@mail.gmail.com>
	<BANLkTimjBfMBXEdH7k-6sTjb1P+Fq3-Fvg@mail.gmail.com>
Date: Thu, 30 Jun 2011 13:23:03 -0500
Message-ID: <BANLkTinciPSnJHHsMo8nfvsYS1AeDov5Tw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add cpufreq driver for Momentum Maple boards
From: kevin diggs <diggskevin38@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Jun 29, 2011 at 3:58 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
>
> drivers/cpufreq/powerpc. However my current version (as suggested by Ben)
> goes directly to drivers/cpufreq
>
Uh ... Just curious ... why is arch specific code now being put
outside of the arch directories? When I wrote the 750GX stuff
(~2.6.28) I put in a location similar to what x86 was doing? When did
this change?

kevin
