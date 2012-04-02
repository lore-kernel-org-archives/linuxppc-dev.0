Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 57258B6EE6
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Apr 2012 18:37:20 +1000 (EST)
Received: by bkcje9 with SMTP id je9so1976147bkc.15
 for <linuxppc-dev@ozlabs.org>; Mon, 02 Apr 2012 01:37:17 -0700 (PDT)
Date: Mon, 2 Apr 2012 10:37:12 +0200
From: Frank =?iso-8859-1?Q?E=2E_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
Message-ID: <20120402083711.GA17733@gnubox>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
 <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
 <CADNf2swF2EVO2u-yPziF2z6HyF6jRBvVsQC2nbY=W2sXJpp2hQ@mail.gmail.com>
 <1333152184.30734.3.camel@pasglop> <20120401221359.GA31730@gnubox>
 <1333332115.30734.27.camel@pasglop>
 <20120402062826.GC2129@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120402062826.GC2129@thor.bakeyournoodle.com>
Cc: Wolfgang Denk <wd@denx.de>, robert.karl.berger@gmail.com,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 02, 2012 at 04:28:29PM +1000, Tony Breeds wrote:
> On Mon, Apr 02, 2012 at 12:01:55PM +1000, Benjamin Herrenschmidt wrote:
> 
> > Ok, I've asked Tony to have a look at splitting the build decision
> > in arch/powerpc/boot along the same lines as the CPU families... ie only
> > wrappers for platforms potentially supported by the built kernel. That
> > should fix it.
> 
> Please try this patch.  Only lightly tested here.  I haven't "split up"
> src-wlib yet as I wanted to verify I'm on the right track.
>

Thanks. It compiles now (for 8xx), but I still need to resolve a
vmalloc failure during boot that occurred sometime after 3.2, so I
haven't been able to test it yet.

You're on the right track. Now continue splitting up src-wlib :)


-- 
Best regards,
Frank
