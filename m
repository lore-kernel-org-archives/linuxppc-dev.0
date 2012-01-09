Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 21E4FB6F9B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2012 06:29:21 +1100 (EST)
Message-ID: <4F0B4002.4050407@freescale.com>
Date: Mon, 9 Jan 2012 13:29:06 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [RFC PATCH 16/16] KVM: PPC: e500mc support
References: <20111221013447.GP8378@schlenkerla.am.freescale.net>
 <4F0B16D7.2000709@redhat.com>
In-Reply-To: <4F0B16D7.2000709@redhat.com>
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

On 01/09/2012 10:33 AM, Avi Kivity wrote:
> On 12/21/2011 03:34 AM, Scott Wood wrote:
>> Add processor support for e500mc, using hardware virtualization support
>> (GS-mode).
>>
>> Current issues include:
>>  - No support for external proxy (coreint) interrupt mode in the guest.
>>
>> Includes work by Ashish Kalra <Ashish.Kalra@freescale.com>,
>> Varun Sethi <Varun.Sethi@freescale.com>, and
>> Liu Yu <yu.liu@freescale.com>.
>>
> 
> Best to include their signoffs, if possible.

These patches are based in part on a bunch of different patches from
these people (for which I did receive signoffs).  I was reluctant to put
their signoff directly on the new patches, since I didn't want to make
it look like they had submitted the patch in anything resembling its
current form.  I wanted to give them credit for what they did, but not
blame for what I did with their code.

I've CCed Varun and Liu so they can sign off these versions of the
patches if they wish.  Ashish no longer works at Freescale, so I don't
have a currently valid e-mail address for him.

-Scott
