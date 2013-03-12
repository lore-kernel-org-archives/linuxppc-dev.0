Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8DE322C02B4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2013 12:06:05 +1100 (EST)
Message-ID: <1363050350.4534.7.camel@pasglop>
Subject: Re: [PATCH -V2 2/2] powerpc: Update kernel VSID range
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoff@infradead.org>
Date: Tue, 12 Mar 2013 12:05:50 +1100
In-Reply-To: <1363048897.3155.16.camel@smoke>
References: <1360942778-21795-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360942778-21795-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1363048897.3155.16.camel@smoke>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: phileas-fogg@mail.ru, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-03-11 at 17:41 -0700, Geoff Levand wrote:
> I didn't seen this fix go in for 3.8.  Did I miss it, or is there some
> reason we don't want it?
> 
> I need this to boot PS3.

Working on it. There's a couple of issues, among others testing on STAB
and a couple of comments from David, I'm hoping to have that sorted some
time today.

Ben.
