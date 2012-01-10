Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD8C8B6FD9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2012 09:20:52 +1100 (EST)
Message-ID: <4F0CB9B7.9020607@freescale.com>
Date: Tue, 10 Jan 2012 16:20:39 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC PATCH 16/16] KVM: PPC: e500mc support
References: <20111221013447.GP8378@schlenkerla.am.freescale.net>
 <4F0B16D7.2000709@redhat.com> <4F0B4002.4050407@freescale.com>
 <4F0BF8BB.4080309@redhat.com>
In-Reply-To: <4F0BF8BB.4080309@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Liu Yu <yu.liu@freescale.com>, kvm@vger.kernel.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org, Varun Sethi <varun.sethi@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/10/2012 02:37 AM, Avi Kivity wrote:
> On 01/09/2012 09:29 PM, Scott Wood wrote:
>>>
>>> Best to include their signoffs, if possible.
>>
>> These patches are based in part on a bunch of different patches from
>> these people (for which I did receive signoffs).  I was reluctant to put
>> their signoff directly on the new patches, since I didn't want to make
>> it look like they had submitted the patch in anything resembling its
>> current form.  I wanted to give them credit for what they did, but not
>> blame for what I did with their code.
>>
> 
> Signoffs are for assigning neither credit nor blame, but for
> attributing authorship and affirming that a contributor has
> the right to contribute code or pass it along.

That's its formal purpose, but some people draw other conclusions from
it regardless.  From Documentation/SubmittingPatches: "Rule (b) allows
you to adjust the code, but then it is very impolite to change one
submitter's code and make him endorse your bugs."

Please read the DCO at
> https://lwn.net/Articles/437739/.

I've read it.  My signoff here qualifies based on (a) and (b).

>         (a) The contribution was created in whole or in part by me and I
>             have the right to submit it under the open source license
>             indicated in the file; or

Note "or in part".  The contributions in this patch were all produced by
Freescale employees on a work for hire basis (other than the extent to
which the code is derived from code already in the Linux kernel, which
is covered by (b)), and I am authorized to submit this work on
Freescale's behalf for inclusion into the Linux kernel under GPLv2.

I'm not trying to be difficult, just to avoid looking like it was a
patch passed more-or-less as-is from person to person.  When I resubmit,
I can put the sign-offs in with [scottwood@freescale.com: significant
rework] after them, or list them separately as part of the "based on..."
paragraph.

-Scott
