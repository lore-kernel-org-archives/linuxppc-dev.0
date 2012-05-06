Return-Path: <robert.karl.berger@gmail.com>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
 (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04168B6FBA
 for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2012 00:37:20 +1000 (EST)
Received: by wgbgn7 with SMTP id gn7so3813795wgb.21
 for <linuxppc-dev@ozlabs.org>; Sun, 06 May 2012 07:37:17 -0700 (PDT)
Message-ID: <4FA68C98.5070209@gmail.com>
Date: Sun, 06 May 2012 17:37:12 +0300
From: Robert Berger <robert.karl.berger@gmail.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
 <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
 <CADNf2swF2EVO2u-yPziF2z6HyF6jRBvVsQC2nbY=W2sXJpp2hQ@mail.gmail.com>
 <1333152184.30734.3.camel@pasglop> <20120401221359.GA31730@gnubox>
 <1333332115.30734.27.camel@pasglop>
 <20120402062826.GC2129@thor.bakeyournoodle.com>
In-Reply-To: <20120402062826.GC2129@thor.bakeyournoodle.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
 =?ISO-8859-1?Q?=22Frank_E=2E_Svendsb=F8e=22?= <frank.svendsboe@gmail.com>
Reply-To: robert.karl.berger@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2012 09:28 AM, Tony Breeds wrote:
> On Mon, Apr 02, 2012 at 12:01:55PM +1000, Benjamin Herrenschmidt wrote:
> 
>> Ok, I've asked Tony to have a look at splitting the build decision
>> in arch/powerpc/boot along the same lines as the CPU families... ie only
>> wrappers for platforms potentially supported by the built kernel. That
>> should fix it.
> 
> Please try this patch.  Only lightly tested here.  I haven't "split up"
> src-wlib yet as I wanted to verify I'm on the right track.

I can confirm that it fixes the kilauea problem. Builds and runs so far.
Are you going to push this upstream?

Regards,

Robert

..."Software is like sex, it's better when it's free"

My public pgp key is available at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1
