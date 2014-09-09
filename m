Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E68A1A021A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 12:32:40 +1000 (EST)
Message-ID: <540E6582.9020403@zytor.com>
Date: Mon, 08 Sep 2014 19:27:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: bit fields && data tearing
References: <21512.10628.412205.873477@gargle.gargle.HOWL>			
 <20140904090952.GW17454@tucnak.redhat.com>			
 <540859EC.5000407@hurleysoftware.com>			
 <20140904175044.4697aee4@alan.etchedpixels.co.uk>			
 <5408C0AB.6050801@hurleysoftware.com>			
 <20140905001751.GL5001@linux.vnet.ibm.com>			
 <1409883098.5078.14.camel@jarvis.lan>		
 <5409243C.4080704@hurleysoftware.com>			
 <20140905040645.GO5001@linux.vnet.ibm.com>			
 <1410066442.12512.13.camel@jarvis.lan>			
 <20140907162146.GK5001@linux.vnet.ibm.com>		
 <1410116687.2027.19.camel@jarvis.lan>	 <540CC305.8010407@hurleysoftware.com>
 <1410155407.2027.29.camel@jarvis.lan>	 <540E1587.3060108@tilera.com>
 <1410216228.2027.88.camel@jarvis.lan>
In-Reply-To: <1410216228.2027.88.camel@jarvis.lan>
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Jelinek <jakub@redhat.com>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 Peter Hurley <peter@hurleysoftware.com>,
 Mikael Pettersson <mikpelinux@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-arch@vger.kernel.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Miroslav Franc <mfranc@redhat.com>,
 Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/08/2014 03:43 PM, James Bottomley wrote:
> 
> This was years ago (possibly decades).  We had to implement in-kernel
> unaligned traps for the networking layer because it could access short
> and int fields that weren't of the correct alignment when processing
> packets.  It that's all corrected now, we wouldn't really notice (except
> a bit of a speed up since an unaligned trap effectively places the
> broken out instructions into the bit stream).
> 
> James
> 

Well, ARM doesn't trap, it just silently gives garbage on unaligned
memory references.

	-hpa
