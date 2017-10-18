Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHG5v2nc1zDrG0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 02:22:58 +1100 (AEDT)
Subject: Re: char/tpm: Improve a size determination in nine functions
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, Julia Lawall
 <julia.lawall@lip6.fr>, Alexander Steffen <Alexander.Steffen@infineon.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain
 <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <83a166af-aecc-649d-dfe3-a72245345209@users.sourceforge.net>
 <1508238182.16112.475.camel@linux.intel.com>
 <c8d37c0407a949c1abb35cfd79c17f58@infineon.com>
 <1508244757.4234.60.camel@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1710171456360.5035@hadrien>
 <1508253453.4234.81.camel@linux.vnet.ibm.com>
 <9689f036-ba9f-d23b-cf89-c289bc308771@users.sourceforge.net>
 <20171018145735.lpzwakatsty7emlw@linux.intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <351cf78a-14f6-c6e7-2902-048e7dc57a14@users.sourceforge.net>
Date: Wed, 18 Oct 2017 17:22:19 +0200
MIME-Version: 1.0
In-Reply-To: <20171018145735.lpzwakatsty7emlw@linux.intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Do you find my wording “This issue was detected by using the
>> Coccinelle software.” insufficient?
> 
> This is fine for cover letter, not for the commits.

I guess that there are more opinions available by other contributors
for this aspect.


> After your analysis software finds an issue you should manually analyze
> what is wrong

This view is generally fine.


> and document that to the commit message.

I tried it in a single paragraph so far (besides the reference
for the tool).


> This applies to sparse, coccinelle or any other tool.

I find that further possibilities can be considered.


> Tool-based commit messages are bad for commit history

I disagree to this view.


> where as clean description gives idea what was done
> (if you have to maintain a GIT tree).

How do you think about to offer any wording for an alternative
which you would find better?


> In my opinion tool is doing all the work but the part
> that you should do is absent.

Really?

Regards,
Markus
